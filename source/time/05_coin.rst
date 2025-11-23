抛硬币
==========

.. raw:: html
    
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>coin</title>
        <style>
            .container {
                text-align: center;
                height: 90%;
                margin: 2%;
                background: rgba(48,100,242,0.3);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            h1 {
                margin-bottom: 10px;
                font-size: 2.5rem;
                text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }
            
            .subtitle {
                margin-bottom: 30px;
                font-size: 1.1rem;
                opacity: 0.9;
            }
            
            .coin-container {
                perspective: 1000px;
                margin: 40px auto;
                width: 200px;
                height: 200px;
            }
            
            .coin {
                width: 100%;
                height: 100%;
                position: relative;
                transform-style: preserve-3d;
                transition: transform 3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            }
            
            .coin.animate {
                animation: flip 3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            }
            
            .coin-face {
                position: absolute;
                width: 100%;
                height: 100%;
                border-radius: 50%;
                backface-visibility: hidden;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 5rem;
                font-weight: bold;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
                border: 8px solid #ffd700;
                background: linear-gradient(145deg, #ffd700, #daa520);
                color: white;
            }
            
            .coin-face.front {
                background: linear-gradient(145deg, #ffd700, #daa520);
            }
            
            .coin-face.back {
                background: linear-gradient(145deg, #daa520, #ffd700);
                transform: rotateY(180deg);
            }
            
            .coin-face::after {
                content: '';
                position: absolute;
                width: 90%;
                height: 90%;
                border-radius: 50%;
                border: 2px solid rgba(255, 255, 255, 0.3);
            }
            
            .controls {
                margin-top: 30px;
            }
            
            .btn {
                width: 20%;
                background: #ffd700;
                color: rgb(48,100,242);
                border: none;
                font-size: 1.2rem;
                font-weight: bold;
                border-radius: 50px;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }
            
            .btn:hover {
                background: #ffed4e;
                transform: translateY(-3px);
            }
            
            
            .result {
                margin-top: 20px;
                font-size: 1.5rem;
                font-weight: bold;
                height: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            
            .stats {
                display: flex;
                justify-content: space-around;
                margin-top: 30px;
                background-color: rgba(98,124,244,0.3);
                border-radius: 15px;
                padding: 15px;
            }
            
            .stat-item {
                text-align: center;
                color: rgba(255,255,255,0.99);
            }
            
            .stat-value {
                font-size: 2rem;
                font-weight: bold;
            }
            
            .stat-label {
                font-size: 0.9rem;
                opacity: 0.8;
            }
            
            @keyframes flip {
                0% {
                    transform: rotateY(0) scale(1);
                }
                20% {
                    transform: rotateY(720deg) scale(1.1);
                }
                40% {
                    transform: rotateY(1440deg) scale(1.05);
                }
                60% {
                    transform: rotateY(2160deg) scale(1.1);
                }
                80% {
                    transform: rotateY(2880deg) scale(1.05);
                }
                100% {
                    transform: rotateY(3600deg) scale(1);
                }
            }
            
            @media (max-width: 480px) {
                .coin-container {
                    width: 150px;
                    height: 150px;
                }
                
                h1 {
                    font-size: 2rem;
                }
                
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="coin-container">
                <div class="coin" id="coin">
                    <div class="coin-face front">正</div>
                    <div class="coin-face back">反</div>
                </div>
            </div>
            
            <div class="result" id="result">点击「抛硬币」开始</div>
            
            <div class="controls">
                <button class="btn" id="flipButton">抛硬币</button>
            </div>
            
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value" id="headsCount">0</div>
                    <div class="stat-label">正面次数</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="tailsCount">0</div>
                    <div class="stat-label">反面次数</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="totalFlips">0</div>
                    <div class="stat-label">总次数</div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const coin = document.getElementById('coin');
                const flipButton = document.getElementById('flipButton');
                const result = document.getElementById('result');
                const headsCount = document.getElementById('headsCount');
                const tailsCount = document.getElementById('tailsCount');
                const totalFlips = document.getElementById('totalFlips');
                
                let isFlipping = false;
                let heads = 0;
                let tails = 0;
                let total = 0;
                
                flipButton.addEventListener('click', function() {
                    if (isFlipping) return;
                    
                    isFlipping = true;
                    result.textContent = "硬币旋转中...";
                    flipButton.disabled = true;
                    
                    // 移除之前的动画类
                    coin.classList.remove('animate');
                    
                    // 触发重绘
                    void coin.offsetWidth;
                    
                    // 添加动画类
                    coin.classList.add('animate');
                    
                    // 随机决定结果
                    const randomResult = Math.random() < 0.5 ? 'heads' : 'tails';
                    
                    // 更新统计数据
                    total++;
                    if (randomResult === 'heads') {
                        heads++;
                    } else {
                        tails++;
                    }
                    
                    // 动画结束后显示结果
                    setTimeout(function() {
                        coin.classList.remove('animate');
                        
                        // 设置最终硬币方向
                        if (randomResult === 'heads') {
                            coin.style.transform = 'rotateY(0deg)';
                            result.textContent = "结果是：正面";
                            result.style.color = "#4CAF50";
                        } else {
                            coin.style.transform = 'rotateY(180deg)';
                            result.textContent = "结果是：反面";
                            result.style.color = "#F44336";
                        }
                        
                        // 更新统计显示
                        headsCount.textContent = heads;
                        tailsCount.textContent = tails;
                        totalFlips.textContent = total;
                        
                        isFlipping = false;
                        flipButton.disabled = false;
                    }, 3000);
                });
            });
        </script>
    </body>
    </html>