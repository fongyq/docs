时间戳
==========

.. raw:: html

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TimeStamp</title>
        <script>
            // https://www.epochconverter.com/
            function cleanTimestamp(e) {
                return e ? ("L" == (e = e.replace(/[`'"\s\,]+/g, "")).charAt(e.length - 1) && (e = e.slice(0, -1)),
                e) : ""
            }

            function epochConverter(e) {
                var hint = document.getElementById("hint");
                if (typeof e != 'number') {
                    e = cleanTimestamp(e);
                    e = parseInt(e);
                }
                if (e >= 1e16 || e <= -1e16) {
                    hint.innerText = "单位：纳秒";
                    e = Math.floor(e / 1e6);
                } else if (e >= 1e14 || e <= -1e14) {
                    hint.innerText = "单位：微秒";
                    e = Math.floor(e / 1e3);
                } else if (e >= 1e11 || e <= -3e10) {
                    hint.innerText = "单位：毫秒";
                } else {
                    hint.innerText = "单位：秒";
                    e *= 1e3;
                }
                return new Date(e);
            }
            function displayTime() {
                var epoch = document.getElementById("timestamp").value;
                var targetTime;
                if (epoch.length == 0) {
                    targetTime = epochConverter(0);
                } else {
                    targetTime = epochConverter(epoch);
                }
                document.getElementById("gmt").innerHTML = targetTime.toUTCString();
                document.getElementById("local").innerHTML = 
                    targetTime.toLocaleDateString() + " " + targetTime.toTimeString();
            }
            window.addEventListener("load", displayTime);
        </script>
        <style>
            canvas {
                border: 1px solid black;
            }
            .time {
                text-align: center; 
                font-size: 30px; 
                color: #2980b9;
            }
            p input[type="text"] {
                border:1px solid rgba(0, 0, 0, 0.1);
                text-align:center;
                background:transparent;
                color:#830303;
                margin:0 auto;
                width:21rem;
                font-size:30px;
                border-radius:0.9rem;
            }
            /*
            input::placeholder {
                color: #2980b9;
            }
            */
        </style>
    </head>
    <body>

        <br>

        <p id="hint" class="time"></p>

        <p style="text-align:center;">
            <input type="text" oninput="displayTime()" id="timestamp" placeholder="0">
        </p>

        <p id="gmt" class="time"></p>

        <p id="local" class="time"></p>
        
        <br>
        <br>
        <br>
        <br>
        <br>

    </body>
    </html>
