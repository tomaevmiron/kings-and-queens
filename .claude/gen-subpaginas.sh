#!/usr/bin/env bash
# Genera las subpáginas de servicios. Uso: bash .claude/gen-subpaginas.sh (desde la raíz del proyecto)
set -e
cd "$(dirname "$0")/.."
WA="https://wa.me/34655805091?text=Hola%20Kings%20and%20Queens%2C%20quiero%20pedir%20cita%20para%20"
IG="https://www.instagram.com/kingsandqueensblanes"
SIMBOLOS=$(awk '/<svg width="0"/,/<\/svg>/' index.html)
CARTEL=$(awk '/<div class="cartel rv" id="cartel">/,/class="aviso"/' index.html)

# cabeza <archivo> <n> <titulo> <title> <descripcion> <og-img> <lead> <wa-texto> <ancla> <texto-boton-2>
cabeza(){ cat > "$1" <<EOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$4 · Kings and Queens</title>
<meta name="description" content="$5">
<meta property="og:title" content="$3 · Kings and Queens Blanes">
<meta property="og:description" content="$5">
<meta property="og:image" content="img/$6">
<meta name="theme-color" content="#0d0d0d">
<link rel="icon" href="img/corona.jpg">
<link rel="apple-touch-icon" href="img/corona.jpg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Anton&family=Archivo:wdth,wght@125,800&family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="estilo.css">
</head>
<body>

$SIMBOLOS

<header class="top">
  <div class="wrap">
    <a class="logo" href="index.html" aria-label="Kings and Queens, inicio"><img src="img/corona.jpg" alt="" width="150" height="150"><span>Kings and Queens</span></a>
    <nav class="nav" aria-label="Secciones">
      <a href="index.html#servicios">Servicios</a><a href="index.html#trabajos">Trabajos</a><a href="index.html#precios">Precios</a><a href="index.html#equipo">Equipo</a><a href="index.html#visita">Visítanos</a>
    </nav>
    <a class="btn btn--sm" href="cita.html">Pide cita</a>
  </div>
</header>

<main>
<section class="hero sub">
  <div class="cara"><img src="img/cara.jpg" alt="" width="240" height="715"></div>
  <div class="wrap">
    <a class="volver" href="index.html#servicios">← Todos los servicios</a>
    <p class="marca">Servicio $2 / 04</p>
    <h1>$3</h1>
    <p class="lead">$7</p>
    <div class="btns">
      <a class="btn btn--full" href="cita.html?s=$2">Pide cita</a>
      <a class="btn" href="#$9">${10}</a>
    </div>
  </div>
</section>
EOF
}

# pie <archivo> <wa-texto> <otros...(html)>
pie(){ cat >> "$1" <<EOF

<section class="sec">
  <div class="wrap lat">
    <h2 class="vert peq">Y además</h2>
    <div>
      <div class="otros">
$3
      </div>
      <div class="cierre rv">
        <a class="btn btn--full" href="$WA$2" target="_blank" rel="noopener"><svg><use href="#i-wa"/></svg>Pide cita por WhatsApp</a>
        <a class="btn" href="index.html#visita"><svg><use href="#i-pin"/></svg>Dónde estamos</a>
      </div>
    </div>
  </div>
</section>
</main>

<footer class="fin">
  <div class="wrap">
    <p class="gran" aria-hidden="true">Kings and Queens</p>
    <p>© 2026 Kings and Queens Tattoo &amp; Piercing Studio · Blanes · <a href="$IG" target="_blank" rel="noopener">Instagram</a> · <a href="https://wa.me/34655805091" target="_blank" rel="noopener">WhatsApp</a></p>
  </div>
</footer>

<nav class="dock" aria-label="Accesos rápidos">
  <a href="cita.html"><svg><use href="#i-wa"/></svg>Pide cita</a>
  <a href="tel:+34655805091"><svg><use href="#i-tel"/></svg>Llamar</a>
  <a href="index.html#visita"><svg><use href="#i-pin"/></svg>Mapa</a>
</nav>

<dialog id="lupa" aria-label="Foto ampliada">
  <button class="x" type="button" aria-label="Cerrar">✕</button>
  <button class="prev" type="button" aria-label="Foto anterior">←</button>
  <button class="next" type="button" aria-label="Foto siguiente">→</button>
  <figure><img src="" alt=""><p></p></figure>
</dialog>

<script src="main.js"></script>
</body>
</html>
EOF
}

O1='        <a class="rv" href="tattoo.html"><span class="n">01</span><h3>Tattoo</h3><p>Ver fotos</p></a>'
O2='        <a class="rv" href="piercing.html"><span class="n">02</span><h3>Piercing</h3><p>Ver precios</p></a>'
O3='        <a class="rv" href="laser.html"><span class="n">03</span><h3>Láser</h3><p>Cómo funciona</p></a>'
O4='        <a class="rv" href="joyeria.html"><span class="n">04</span><h3>Joyería</h3><p>Qué tenemos</p></a>'
NL=$'\n'

foto(){ echo "        <a class=\"rv\" href=\"img/$1.jpg\" data-cap=\"$2\"><img src=\"img/$1.jpg\" alt=\"$3\" loading=\"lazy\"><span>$2</span></a>"; }

# ============ TATTOO ============
F=tattoo.html
cabeza $F 01 "Tattoo" "Tatuajes en Blanes" "Tatuajes en Blanes: realismo, black and grey y color. Mira las fotos de los últimos trabajos y pide cita en Kings and Queens." t10.jpg \
  "Realismo, black &amp; grey y color. Piezas que se dibujan para quien las va a llevar, desde un detalle pequeño hasta una manga entera." "un%20tatuaje." fotos "Ver fotos"
cat >> $F <<EOF

<section class="sec">
  <div class="wrap lat">
    <h2 class="vert">Cómo es</h2>
    <div class="ficha">
      <div class="rv">
        <p class="marca">Tinta a medida</p>
        <h3 class="wide">Manda la luz <span class="sl">//</span> y la sombra</h3>
        <p class="lead">Lo que más sale del estudio es realismo: retratos, animales, miradas y esculturas trabajadas por capas de sombra hasta que tienen volumen de fotografía.</p>
        <p class="lead">Trae una referencia, dinos la zona y el tamaño, y te preparamos el diseño. Si aún no lo tienes claro, lo pensamos juntos.</p>
      </div>
      <aside class="caja rv" style="--rd:.12s">
        <h3 class="wide">Ideal para</h3>
        <ul>
          <li>Retratos y mascotas</li>
          <li>Animales y fauna salvaje</li>
          <li>Mangas y medias mangas</li>
          <li>Piezas a color</li>
          <li>Tapar o renovar un tatuaje antiguo</li>
        </ul>
      </aside>
    </div>
  </div>
</section>

<section class="sec" id="fotos">
  <div class="wrap lat">
    <h2 class="vert">Fotos</h2>
    <div>
      <div class="intro rv">
        <p class="marca">Tattoo en piel</p>
        <h3 class="wide">Toca <span class="sl">//</span> para ampliar</h3>
      </div>
      <div class="galeria">
$(foto t01 "Retrato" "Retrato realista de un futbolista sonriendo en el brazo")
$(foto t10 "León" "León realista en el antebrazo")
$(foto t05 "Hannya" "Manga con máscara hannya a color")
$(foto t11 "Gladiador" "Gladiador con casco y coliseo en el hombro")
$(foto t09 "Tigre y mirada" "Ojo de tigre y mirada de mujer en el antebrazo")
$(foto t07 "Águila" "Águila en black and grey en el antebrazo")
$(foto t02 "Cristo y cruz" "Rostro de Cristo y cruz en el antebrazo")
$(foto t06 "Ojo y reloj" "Ojo, reloj y rosa en el antebrazo")
$(foto t08 "Rostro" "Rostro de mujer en black and grey")
$(foto t03 "Espacio" "Astronauta y criatura espacial en el antebrazo")
      </div>
      <p class="pocas rv">Los trabajos más recientes, en vídeo, están en <a href="$IG" target="_blank" rel="noopener">@kingsandqueensblanes</a>.</p>
    </div>
  </div>
</section>
EOF
pie $F "un%20tatuaje." "$O2$NL$O3$NL$O4"

# ============ PIERCING ============
F=piercing.html
cabeza $F 02 "Piercing" "Piercing en Blanes · Lista de precios" "Piercing en Blanes desde 15 €: oreja, nariz, facial, lengua, ombligo, microdermal y surface. Lista de precios completa y cita por WhatsApp." ig-precios.jpg \
  "Oreja, nariz, facial y cuerpo. Consulta la lista de precios, marca los que te quieras hacer y pide cita con el total ya calculado." "un%20piercing." lista "Ver precios"
cat >> $F <<EOF

<section class="sec precios" id="lista">
  <div class="wrap lat">
    <h2 class="vert peq">Piercing pricing list</h2>
    <div>
      $CARTEL
    </div>
  </div>
</section>

<section class="sec">
  <div class="wrap lat">
    <h2 class="vert">Cuidados</h2>
    <div>
      <div class="intro rv">
        <p class="marca">Después de perforar</p>
        <h3 class="wide">Lo que conviene <span class="sl">//</span> saber</h3>
      </div>
      <div class="dudas rv">
        <details open><summary>¿Cómo lo limpio?</summary><p>Con suero fisiológico y una gasa limpia, un par de veces al día. Sin alcohol, sin agua oxigenada y sin girar la joya.</p></details>
        <details><summary>¿Cuánto tarda en curar?</summary><p>Depende de la zona: un lóbulo cura en pocas semanas y un cartílago puede necesitar varios meses. Al hacértelo te decimos el plazo del tuyo.</p></details>
        <details><summary>¿Cuándo puedo cambiar la joya?</summary><p>Cuando esté curado del todo. Si tienes dudas, pásate y lo miramos antes de cambiarla.</p></details>
        <details><summary>¿Qué debo evitar los primeros días?</summary><p>Tocarlo con las manos sucias, dormir encima, piscina y playa, y el maquillaje o las cremas sobre la zona.</p></details>
        <details><summary>¿Y si se inflama?</summary><p>Un poco de hinchazón al principio es normal. Si va a más, duele o supura, escríbenos o ven al estudio y lo revisamos.</p></details>
      </div>
    </div>
  </div>
</section>
EOF
pie $F "un%20piercing." "$O1$NL$O3$NL$O4"

# ============ LÁSER ============
F=laser.html
cabeza $F 03 "Láser" "Eliminación de tatuajes con láser en Blanes" "Eliminación de tatuajes con láser en Blanes. Para borrar o aclarar un tatuaje antes de taparlo. Pide valoración en Kings and Queens." t08.jpg \
  "Eliminación de tatuajes con láser: para borrar del todo una pieza que ya no va contigo o aclararla antes de tatuar encima." "una%20eliminaci%C3%B3n%20l%C3%A1ser." dudas "Dudas frecuentes"
cat >> $F <<EOF

<section class="sec">
  <div class="wrap lat">
    <h2 class="vert">Cómo es</h2>
    <div class="ficha">
      <div class="rv">
        <p class="marca">Sesión a sesión</p>
        <h3 class="wide">Borrar <span class="sl">//</span> o aclarar</h3>
        <p class="lead">El láser rompe la tinta en partículas muy pequeñas que el cuerpo va eliminando con las semanas. Por eso se trabaja por sesiones, dejando descansar la piel entre una y otra.</p>
        <p class="lead">Cada tatuaje responde distinto según el color, la profundidad y los años que tenga. Enséñanoslo y te decimos qué se puede esperar del tuyo.</p>
      </div>
      <aside class="caja rv" style="--rd:.12s">
        <h3 class="wide">Ideal para</h3>
        <ul>
          <li>Tatuajes que ya no te representan</li>
          <li>Aclarar antes de un cover</li>
          <li>Corregir trazos o zonas concretas</li>
          <li>Nombres y fechas</li>
        </ul>
      </aside>
    </div>
  </div>
</section>

<section class="sec" id="dudas">
  <div class="wrap lat">
    <h2 class="vert">Dudas</h2>
    <div>
      <div class="intro rv">
        <p class="marca">Antes de empezar</p>
        <h3 class="wide">Lo que más <span class="sl">//</span> nos preguntan</h3>
      </div>
      <div class="dudas rv">
        <details open><summary>¿Cuántas sesiones hacen falta?</summary><p>No hay un número fijo: depende de la tinta, el color y la zona. Lo valoramos viendo el tatuaje, en el estudio o con una foto por WhatsApp.</p></details>
        <details><summary>¿Cuánto hay que esperar entre sesiones?</summary><p>La piel necesita varias semanas para recuperarse y eliminar la tinta. Te marcamos el calendario después de cada sesión.</p></details>
        <details><summary>¿Se puede tatuar encima después?</summary><p>Sí. Muchas veces basta con aclarar la pieza antigua para que el nuevo diseño tenga mucha más libertad.</p></details>
        <details><summary>¿Qué cuidados necesita?</summary><p>Zona limpia e hidratada, nada de sol directo y no rascar ni arrancar las costras. Te lo explicamos todo al acabar.</p></details>
        <details><summary>¿Cuánto cuesta?</summary><p>Va según el tamaño del tatuaje. Escríbenos con una foto y te damos precio por sesión.</p></details>
      </div>
    </div>
  </div>
</section>
EOF
pie $F "una%20eliminaci%C3%B3n%20l%C3%A1ser." "$O1$NL$O2$NL$O4"

# ============ JOYERÍA ============
F=joyeria.html
cabeza $F 04 "Joyería" "Joyería para piercing en Blanes" "Joyería para piercing en Blanes: aros, labrets, barras y piezas de todo tipo para estrenar o renovar tu piercing. Kings and Queens." nariz.jpg \
  "Joyas de todo tipo para estrenar un piercing o renovar el que ya llevas. Ven a verlas y te ayudamos con la medida y el cambio." "una%20consulta%20de%20joyer%C3%ADa." piezas "Qué tenemos"
cat >> $F <<EOF

<section class="sec" id="piezas">
  <div class="wrap lat">
    <h2 class="vert">Piezas</h2>
    <div class="ficha">
      <div class="rv">
        <p class="marca">En el mostrador</p>
        <h3 class="wide">Elegir <span class="sl">//</span> la joya</h3>
        <p class="lead">Una joya bien elegida cambia un piercing: el grosor, el largo y la forma tienen que ser los de tu perforación, no solo gustarte.</p>
        <p class="lead">En el estudio tenemos joyería de todo tipo y te decimos cuál encaja con tu perforación. Si quieres, te la cambiamos aquí mismo.</p>
      </div>
      <aside class="caja rv" style="--rd:.12s">
        <h3 class="wide">Qué vas a encontrar</h3>
        <ul>
          <li>Aros y clickers</li>
          <li>Labrets y barras</li>
          <li>Septum y nostril</li>
          <li>Ombligo, lengua y pezón</li>
          <li>Piezas para microdermal</li>
        </ul>
      </aside>
    </div>
  </div>
</section>

<section class="sec equipo">
  <div class="wrap">
    <p class="marca rv">Kings and Queens</p>
    <h2 class="rv">Ven a verlas</h2>
    <figure class="rv"><img src="img/nariz.jpg" alt="Primer plano de un aro dorado en la nariz" loading="lazy" width="297" height="190"></figure>
    <p class="lead rv">Lo que hay en el mostrador cambia a menudo. Pásate por la Plaça de Catalunya o pregúntanos por WhatsApp por la pieza que buscas.</p>
    <a class="btn rv" href="${WA}una%20consulta%20de%20joyer%C3%ADa." target="_blank" rel="noopener">Pregunta por tu joya</a>
  </div>
</section>
EOF
pie $F "una%20consulta%20de%20joyer%C3%ADa." "$O1$NL$O2$NL$O3"


# ============ CITA ============
F=cita.html
cabeza $F 00 "Pide cita" "Pide cita en Blanes" "Pide cita en Kings and Queens para tatuaje, piercing, eliminación láser o joyería. Elige servicio y horario y envíalo por WhatsApp." ig-precios.jpg \
  "Marca lo que tengas claro y te abrimos WhatsApp con el mensaje ya escrito. Lo demás lo hablamos." "" form ""
sed -i -e '/<div class="btns">/,/<\/div>/d' -e 's#<p class="marca">Servicio 00 / 04</p>#<p class="marca">Empieza por aquí</p>#' -e 's#index.html\#servicios">← Todos los servicios#index.html">← Volver al inicio#' $F
cat >> $F <<EOF2

<section class="sec" id="form">
  <div class="wrap lat">
    <h2 class="vert">Tu cita</h2>
    <div class="ficha">
      <form class="form rv" id="idea">
        <fieldset><legend>Qué quieres hacerte</legend><div class="chips">
          <label><input type="radio" name="serv" value="un tatuaje"><span>Tattoo</span></label>
          <label><input type="radio" name="serv" value="un piercing"><span>Piercing</span></label>
          <label><input type="radio" name="serv" value="una eliminación láser"><span>Eliminación láser</span></label>
          <label><input type="radio" name="serv" value="una consulta de joyería"><span>Joyería</span></label>
        </div></fieldset>
        <fieldset><legend>Cuándo te va mejor</legend><div class="chips">
          <label><input type="radio" name="hora" value="por la mañana (11–13 h)"><span>Mañana · 11–13 h</span></label>
          <label><input type="radio" name="hora" value="por la tarde (17–20 h)"><span>Tarde · 17–20 h</span></label>
          <label><input type="radio" name="hora" value="me da igual el horario"><span>Me da igual</span></label>
        </div></fieldset>
        <fieldset><legend><label for="txt">Tu idea</label></legend>
          <textarea id="txt" name="txt" placeholder="Ej.: un león en el antebrazo, unos 15 cm…"></textarea>
        </fieldset>
        <button class="btn btn--full" type="submit"><svg><use href="#i-wa"/></svg>Enviar por WhatsApp</button>
        <p class="note">No guardamos nada: el mensaje se abre en tu WhatsApp y lo envías tú.</p>
      </form>
      <aside class="caja rv" style="--rd:.12s">
        <h3 class="wide">O si lo prefieres</h3>
        <ul>
          <li>Llámanos al <a href="tel:+34655805091">655 80 50 91</a></li>
          <li>Pásate por Plaça de Catalunya, 2</li>
          <li>Martes a sábado · 11–13 h y 17–20 h</li>
          <li id="estado"><span>Domingo y lunes cerrado</span></li>
        </ul>
      </aside>
    </div>
  </div>
</section>
EOF2
pie $F "" "$O1$NL$O2$NL$O3"
sed -i -e 's#<h2 class="vert peq">Y además</h2>#<h2 class="vert peq">Servicios</h2>#' -e '/Pide cita por WhatsApp/d' $F

echo "Generadas: tattoo.html piercing.html laser.html joyeria.html cita.html"
