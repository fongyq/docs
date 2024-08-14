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
                document.getElementById("local-time").innerHTML = targetTime.toLocaleString();
                var s = targetTime.toTimeString().split(' ');
                s.splice(0, 1);
                var days = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
                document.getElementById("local-day").innerHTML = days[targetTime.getDay()];
                document.getElementById("local-tz").innerHTML = s.join(' ');
            }
            window.addEventListener("load", displayTime);
        </script>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: none;
            }
            th, td {
                padding: 10px;
                text-align: left;
                font-size: 30px; 
                color: #2980b9;
            }
            th:first-child, td:first-child {
                text-align: right;
                color: gray;
            }
            th:nth-child(2), td:nth-child(2) {
                text-align: left;
            }
            .top {
                margin-top: 20px;
                margin-bottom: 20px;
            }
            .text-center {
                text-align: center;
            }
            .time { 
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
            p input[type="text"]:focus {
                outline: none;
                border: 1px solid rgb(180,20,20,0.8);
            }
        </style>
    </head>
    <body>

        <div id="hint" class="time text-center top"></div>

        <p style="text-align:center;">
            <input type="text" oninput="displayTime()" id="timestamp" placeholder="0">
        </p>

        <table style="margin: 0 auto 20px;">
            <tr>
                <td>GMT:</td>
                <td><span id="gmt"></span></td>
            </tr>
            <tr>
                <td>你的时区:</td>
                <td><span id="local-day"></span></td>
            </tr>
            <tr>
                <td></td>
                <td><span id="local-time"></span></td>
            </tr>
            <tr>
                <td></td>
                <td><span id="local-tz"></span></td>
            </tr>
        </table>

    </body>
    </html>
