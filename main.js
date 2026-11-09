(() => {
  const WA = 'https://wa.me/34655805091?text=';

  /* --- aparecer al entrar --- */
  const io = new IntersectionObserver(es => es.forEach(e => { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } }), { threshold: .12, rootMargin: '0px 0px -5% 0px' });
  document.querySelectorAll('.rv').forEach(el => io.observe(el));

  /* --- abierto / cerrado (hora de Blanes, horario partido) --- */
  const T = [[11, 13], [17, 20]];
  const H = { 0: [], 1: [], 2: T, 3: T, 4: T, 5: T, 6: T };
  const dias = ['domingo', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado'];
  const el = document.getElementById('estado');
  try {
    const parts = new Intl.DateTimeFormat('en-GB', { timeZone: 'Europe/Madrid', weekday: 'short', hour: '2-digit', minute: '2-digit', hour12: false }).formatToParts(new Date());
    const get = k => parts.find(p => p.type === k).value;
    const d = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].indexOf(get('weekday'));
    const now = (+get('hour') % 24) + +get('minute') / 60;
    const row = document.querySelector(`#horario tr[data-d="${d}"]`); if (row) row.classList.add('hoy');
    if (el) {
      const tx = el.querySelector('span');
      const tramo = H[d].find(([a, b]) => now >= a && now < b);
      if (tramo) { el.classList.add('abierto'); tx.textContent = `Abierto ahora · hasta las ${tramo[1]}:00`; }
      else {
        el.classList.add('cerrado');
        const hoy = H[d].find(([a]) => now < a);
        if (hoy) tx.textContent = `Cerrado · abrimos hoy a las ${hoy[0]}:00`;
        else {
          let n = d; do { n = (n + 1) % 7; } while (!H[n].length);
          tx.textContent = `Cerrado · abrimos el ${dias[n]} a las ${H[n][0][0]}:00`;
        }
      }
    }
  } catch (e) {}

  /* --- trabajos: flechas de la tira --- */
  const tira = document.getElementById('tira');
  if (tira) document.querySelectorAll('.mando button').forEach(b => b.addEventListener('click', () => {
    const paso = tira.querySelector('figure').offsetWidth + 16;
    tira.scrollBy({ left: paso * 2 * +b.dataset.dir, behavior: 'smooth' });
  }));

  /* --- lista de precios: marcar piercings y sumar --- */
  const cartel = document.getElementById('cartel');
  if (cartel) {
    const total = document.getElementById('total'), cuantos = document.getElementById('cuantos'), pedir = document.getElementById('pedir');
    const nombre = b => b.firstChild.textContent.trim();
    const suma = () => {
      const on = [...cartel.querySelectorAll('button[aria-pressed=true]')];
      const t = on.reduce((s, b) => s + +b.dataset.p, 0);
      total.textContent = t + ' €';
      cuantos.textContent = on.length ? `${on.length} ${on.length > 1 ? 'piercings' : 'piercing'} · ${on.map(nombre).join(', ')}` : 'Toca los que te quieras hacer';
      const msg = on.length
        ? `Hola Kings and Queens, quiero pedir cita para ${on.length > 1 ? 'estos piercings' : 'este piercing'}:\n${on.map(b => `· ${nombre(b)} (${b.dataset.p} €)`).join('\n')}\nTotal según la lista: ${t} €`
        : 'Hola Kings and Queens, quiero pedir cita para un piercing.';
      pedir.href = WA + encodeURIComponent(msg);
    };
    cartel.addEventListener('click', e => {
      const b = e.target.closest('li button'); if (!b) return;
      b.setAttribute('aria-pressed', b.getAttribute('aria-pressed') !== 'true');
      suma();
    });
  }

  /* --- formulario → WhatsApp --- */
  const idea = document.getElementById('idea');
  if (idea) idea.addEventListener('submit', e => {
    e.preventDefault();
    const f = new FormData(e.target);
    const l = [`Hola Kings and Queens, quiero pedir cita${f.get('serv') ? ' para ' + f.get('serv') : ''}.`];
    if (f.get('hora')) l.push('Horario: ' + f.get('hora'));
    const t = (f.get('txt') || '').trim(); if (t) l.push('Idea: ' + t);
    window.open(WA + encodeURIComponent(l.join('\n')), '_blank', 'noopener');
  });

  /* --- subpáginas: ampliar foto --- */
  const lb = document.getElementById('lupa');
  if (lb && lb.showModal) {
    const links = [...document.querySelectorAll('.galeria a')], im = lb.querySelector('img'), cap = lb.querySelector('p');
    let cur = 0;
    const show = i => { cur = (i + links.length) % links.length; const a = links[cur]; im.src = a.getAttribute('href'); im.alt = a.querySelector('img').alt; cap.textContent = `${a.dataset.cap} · ${cur + 1}/${links.length}`; };
    links.forEach((a, i) => a.addEventListener('click', e => { e.preventDefault(); show(i); lb.showModal(); }));
    lb.querySelector('.x').addEventListener('click', () => lb.close());
    lb.querySelector('.prev').addEventListener('click', () => show(cur - 1));
    lb.querySelector('.next').addEventListener('click', () => show(cur + 1));
    lb.addEventListener('click', e => { if (e.target === lb || e.target.tagName === 'FIGURE') lb.close(); });
    lb.addEventListener('keydown', e => { if (e.key === 'ArrowLeft') show(cur - 1); if (e.key === 'ArrowRight') show(cur + 1); });
  }
})();
