import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15 // 引入Qt枚举（如Qt.LeftButton）

Rectangle {
    // 手绘核心属性
    property var drawPathPoints: [] // 手绘路径坐标点数组
    property bool isDrawing: false  // 画线状态标记
    // ✅ 新增：校验总开关【重置后关闭，手绘时开启】
    property bool isCheckEnable: true // 控制是否执行测试完成校验，false=完全屏蔽
    
    // 平行线区域填充属性（双独立标记）
    property bool isFillFirstArea: false  // 是否填充第一条平行线区域（左上↔右下）
    property bool isFillSecondArea: false // 是否填充第二条平行线区域（左下↔右上）
    property color parallelAreaColor: "#add8e6" // 平行线区域填充色
    
    // 矩阵基础属性（保留原逻辑）
    property var blueCells: []
    property color cellBlue: "#add8e6" 
    
    // 测试完成标记位
    property bool isTestCompleted: false // 防止重复打印完成提示

    // 基础样式
    border.color: "#666"
    border.width: 4
    color: "white"

    // ========== 初始化所有数据 ==========
    Component.onCompleted: {
        initAllData()
    }

    // ========== 离开界面【清数据+强制刷新画布】双操作（彻底杜绝残留） ==========
    // 场景1：界面被销毁 → 彻底清空+刷新
    Component.onDestruction: {
        resetAllData()
        console.log("🔄 界面销毁，数据清空+画布刷新完成！")
    }
    // 场景2：界面隐藏/显示 监听
    onVisibleChanged: {
        if(!visible) {
            resetAllData() // 离开必清+必刷新
            console.log("🔄 界面隐藏，数据清空+画布刷新完成！")
        } else {
            // 再次进入界面 → 强制重绘画布，视觉清零
            cvs.requestPaint()
            console.log("🔄 再次进入界面，画布重载刷新完成！")
        }
    }

    // ========== 统一重置函数【清数据+强制刷新画布】 ==========
    function initAllData() {
        blueCells = new Array(13);
        for(let c = 0; c < 13; c++) {
            blueCells[c] = new Array(9).fill(false);
        }
        drawPathPoints = [];
        isDrawing = false;
        isFillFirstArea = false;
        isFillSecondArea = false;
        isTestCompleted = false;
    }
    function resetAllData() {
        initAllData()          
        cvs.requestPaint()     
        cvs.getContext("2d").clearRect(0,0,cvs.width,cvs.height);
        // ✅ 新增：重置时关闭校验开关，彻底屏蔽校验逻辑
        isCheckEnable = false;
    }

    Canvas{
        id: cvs
        anchors.fill: parent
        antialiasing: true
        z: 1
        // Canvas可见时强制触发绘制（兜底保障）
        onVisibleChanged: if(visible) requestPaint()

        // 判定可填充蓝色小矩阵
        function isFillableCell(col, row) {
            const isHollow = (
                (col >=1 && col <=5 && (row >=1 && row <=3 || row >=5 && row <=7)) 
                || 
                (col >=7 && col <=11 && (row >=1 && row <=3 || row >=5 && row <=7))
            );
            return !isHollow;
        }

        // 校验测试是否完成
        function checkTestCompletion() {
            // ✅ 核心拦截：校验开关关闭，直接退出，不执行任何校验
            if(!isCheckEnable) return;
            
            if(isTestCompleted) return;
            const isAllParallelFilled = isFillFirstArea && isFillSecondArea;
            if(!isAllParallelFilled) return;

            let isAllCellsFilled = true;
            const colNum = 13;
            const rowNum = 9;
            for(let col = 0; col < colNum; col++) {
                for(let row = 0; row < rowNum; row++) {
                    if(cvs.isFillableCell(col, row) && !blueCells[col][row]) {
                        isAllCellsFilled = false;
                        break;
                    }
                }
                if(!isAllCellsFilled) break;
            }

            if(isAllCellsFilled && isAllParallelFilled) {
                isTestCompleted = true;
                console.log("Touch test successful!");
                
                isClicked = true;
            }
        }

        onPaint: {
            const ctx = getContext("2d")
            const colNum = 13
            const rowNum = 9
            const cw = cvs.width / colNum
            const ch = cvs.height / rowNum

            // 第一步强制清空画布（杜绝任何绘制残留）
            ctx.clearRect(0, 0, cvs.width, cvs.height);

            // 层级1：绘制可填充矩阵的填充色
            for(let col = 0; col < colNum; col++) {
                for(let row = 0; row < rowNum; row++) {
                    if(isFillableCell(col, row)) {
                        ctx.fillStyle = blueCells[col][row] ? cellBlue : "white";
                        ctx.fillRect(col*cw, row*ch, cw, ch);
                    }
                }
            }

            // 层级2：绘制平行线区域填充
            ctx.save();
            ctx.fillStyle = parallelAreaColor;
            ctx.strokeStyle = "transparent";

            if(isFillFirstArea) {
                const p1_bl = {x:0*cw, y:1*ch};
                const p2_bl = {x:12*cw, y:9*ch};
                const p1_tr = {x:1*cw, y:0*ch};
                const p2_tr = {x:13*cw, y:8*ch};
                ctx.beginPath();
                ctx.moveTo(p1_tr.x, p1_tr.y);
                ctx.lineTo(p2_tr.x, p2_tr.y);
                ctx.lineTo(p2_bl.x, p2_bl.y);
                ctx.lineTo(p1_bl.x, p1_bl.y);
                ctx.closePath();
                ctx.fill();
            }

            if(isFillSecondArea) {
                const p1_tl = {x:0*cw, y:8*ch};
                const p2_tl = {x:12*cw, y:0*ch};
                const p1_br = {x:1*cw, y:9*ch};
                const p2_br = {x:13*cw, y:1*ch};
                ctx.beginPath();
                ctx.moveTo(p1_tl.x, p1_tl.y);
                ctx.lineTo(p2_tl.x, p2_tl.y);
                ctx.lineTo(p2_br.x, p2_br.y);
                ctx.lineTo(p1_br.x, p1_br.y);
                ctx.closePath();
                ctx.fill();
            }
            ctx.restore();

            // 层级3：绘制可填充矩阵黑色轮廓
            ctx.save();
            ctx.strokeStyle = "black";
            ctx.lineWidth = 1;
            for(let col = 0; col < colNum; col++) {
                for(let row = 0; row < rowNum; row++) {
                    if(isFillableCell(col, row)) {
                        ctx.strokeRect(col*cw, row*ch, cw, ch);
                    }
                }
            }
            ctx.restore();

            // 层级4：绘制4条黑色交叉双线
            ctx.save()
            ctx.strokeStyle = "black";
            ctx.lineWidth = 1;
            ctx.lineCap = "round";
            ctx.beginPath(); ctx.moveTo(0, ch); ctx.lineTo((colNum-1)*cw, cvs.height); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cw, 0); ctx.lineTo(cvs.width, (rowNum-1)*ch); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(0, (rowNum-1)*ch); ctx.lineTo((colNum-1)*cw, 0); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cw, cvs.height); ctx.lineTo(cvs.width, ch); ctx.stroke();
            ctx.restore()

            // 层级5：绘制四角落叉形
            ctx.save()
            ctx.strokeStyle = "black";
            ctx.lineWidth = 2;
            const cm = Math.min(cw, ch) * 0.1;
            ctx.beginPath(); ctx.moveTo(cm, cm); ctx.lineTo(cw-cm, ch-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cw-cm, cm); ctx.lineTo(cm, ch-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo((colNum-1)*cw+cm, cm); ctx.lineTo(cvs.width-cm, ch-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cvs.width-cm, cm); ctx.lineTo((colNum-1)*cw+cm, ch-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cm, (rowNum-1)*ch+cm); ctx.lineTo(cw-cm, cvs.height-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cw-cm, (rowNum-1)*ch+cm); ctx.lineTo(cm, cvs.height-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo((colNum-1)*cw+cm, (rowNum-1)*ch+cm); ctx.lineTo(cvs.width-cm, cvs.height-cm); ctx.stroke();
            ctx.beginPath(); ctx.moveTo(cvs.width-cm, (rowNum-1)*ch+cm); ctx.lineTo((colNum-1)*cw+cm, cvs.height-cm); ctx.stroke();
            ctx.restore()

            // 层级6：绘制手绘线【绿/红动态变色】
            if(isDrawing && drawPathPoints.length > 1) {
                ctx.save()
                let lineColor = "red";
                const triggerType = cvs.checkPathStartEnd(drawPathPoints);
                if(triggerType > 0 && cvs.isPathFullyInArea(drawPathPoints, triggerType)){
                    lineColor = "#00c853";
                }
                ctx.strokeStyle = lineColor;       
                ctx.lineWidth = 2;             
                ctx.lineCap = "round";         
                ctx.lineJoin = "round";        
                ctx.globalCompositeOperation = "source-over";
                ctx.beginPath();
                ctx.moveTo(drawPathPoints[0].x, drawPathPoints[0].y);
                for(let i = 1; i < drawPathPoints.length; i++) {
                    ctx.lineTo(drawPathPoints[i].x, drawPathPoints[i].y);
                }
                ctx.stroke();
                ctx.restore()
            }
        }

        // ========== 保留所有区域判断/路径校验/填充触发逻辑 ==========
        function getCellVertex(col, row) {
            const cw = cvs.width / 13;
            const ch = cvs.height / 9;
            return {
                tl: {x: col*cw, y: row*ch},
                tr: {x: (col+1)*cw, y: row*ch},
                bl: {x: col*cw, y: (row+1)*ch},
                br: {x: (col+1)*cw, y: (row+1)*ch}
            };
        }

        function isInFirstParallelArea(point) {
            const cw = cvs.width /13;
            const ch = cvs.height /9;
            const k1 = (9*ch - 1*ch) / (12*cw - 0*cw);
            const b1 = 1*ch - k1*0*cw;
            const y1 = k1 * point.x + b1;
            const k2 = (8*ch - 0*ch) / (13*cw - 1*cw);
            const b2 = 0*ch - k2*1*cw;
            const y2 = k2 * point.x + b2;
            return (point.y >= y2 && point.y <= y1);
        }

        function isInSecondParallelArea(point) {
            const cw = cvs.width /13;
            const ch = cvs.height /9;
            const k1 = (0*ch - 8*ch) / (12*cw - 0*cw);
            const b1 = 8*ch - k1*0*cw;
            const y1 = k1 * point.x + b1;
            const k2 = (1*ch - 9*ch) / (13*cw - 1*cw);
            const b2 = 9*ch - k2*1*cw;
            const y2 = k2 * point.x + b2;
            return (point.y >= y1 && point.y <= y2);
        }

        function crossProduct(p1, p2, p) {
            return (p2.x - p1.x) * (p.y - p1.y) - (p2.y - p1.y) * (p.x - p1.x);
        }

        function isPathInArea(allPoints, areaType) {
            if(allPoints.length < 2) return false;
            let inAreaCount = 0;
            allPoints.forEach(p => {
                const inArea = areaType ===1 ? isInFirstParallelArea(p) : isInSecondParallelArea(p);
                if(inArea) inAreaCount++;
            });
            return (inAreaCount / allPoints.length) >= 0.95;
        }

        function isPathFullyInArea(allPoints, areaType) {
            if(allPoints.length < 2) return false;
            let allInArea = true;
            allPoints.forEach(p => {
                const inArea = areaType ===1 ? isInFirstParallelArea(p) : isInSecondParallelArea(p);
                if(!inArea) allInArea = false;
            });
            return allInArea;
        }

        function fillParallelArea(areaType) {
            if(areaType === 1) isFillFirstArea = true;
            else if(areaType === 2) isFillSecondArea = true;
            cvs.requestPaint();
            console.log(`✅ 填充平行线区域成功！类型：${areaType===1?"第一条（左上↔右下）":"第二条（左下↔右上）"}`);
            cvs.checkTestCompletion();
        }

        function checkPathStartEnd(points) {
            if(points.length <2) return 0;
            const cw = cvs.width/13; const ch = cvs.height/9;
            const start = {col:Math.floor(points[0].x/cw), row:Math.floor(points[0].y/ch)};
            const end = {col:Math.floor(points[points.length-1].x/cw), row:Math.floor(points[points.length-1].y/ch)};
            if((start.col===0 && start.row===0 && end.col===12 && end.row===8) || 
               (start.col===12 && start.row===8 && end.col===0 && end.row===0)) return 1;
            if((start.col===0 && start.row===8 && end.col===12 && end.row===0) || 
               (start.col===12 && start.row===0 && end.col===0 && end.row===8)) return 2;
            return 0;
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        z: 2
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        preventStealing: true
        
        onPressed: (mouse) => {
            if(mouse.button === Qt.LeftButton) {
                isDrawing = true;
                drawPathPoints = [{x: mouse.x, y: mouse.y}];
                // ✅ 新增：开始手绘时，恢复校验开关，保证正常操作时校验生效
                isCheckEnable = true;
                cvs.requestPaint();
            }
        }

        onReleased: (mouse) => {
            if(mouse.button !== Qt.LeftButton) return;
            const fullDrawPath = [...drawPathPoints];
            isDrawing = false;
            drawPathPoints = [];
            cvs.requestPaint();
            Qt.callLater(()=>{
                const triggerType = cvs.checkPathStartEnd(fullDrawPath);
                if(triggerType === 1 || triggerType ===2) {
                    const isAllInArea = cvs.isPathInArea(fullDrawPath, triggerType);
                    if(isAllInArea) cvs.fillParallelArea(triggerType);
                    else console.log("❌ 路径超出平行线区域，未触发填充");
                } else console.log("❌ 起点/终点不匹配，未触发填充");
                cvs.requestPaint();
            });
        }

        onExited: {
            if(isDrawing) {
                isDrawing = false;
                drawPathPoints = [];
                cvs.requestPaint();
            }
        }

        onPositionChanged: {
            const cw = cvs.width / 13;
            const ch = cvs.height / 9;
            if(isDrawing) {
                const lastPoint = drawPathPoints[drawPathPoints.length - 1];
                if(Math.abs(mouseX - lastPoint.x) > 0.5 || Math.abs(mouseY - lastPoint.y) > 0.5) {
                    drawPathPoints.push({x: mouseX, y: mouseY});
                    cvs.requestPaint();
                }
            }
            if(isDrawing) {
                const curCol = Math.floor(mouseX / cw);
                const curRow = Math.floor(mouseY / ch);
                if(curCol >= 0 && curCol <13 && curRow >=0 && curRow <9) {
                    if(cvs.isFillableCell(curCol, curRow) && !blueCells[curCol][curRow]) {
                        blueCells[curCol][curRow] = true;
                        cvs.requestPaint();
                        cvs.checkTestCompletion();
                    }
                }
            }
        }
    }

    // ✅ 重置按钮 - 核心改动：z:999 强制置顶最上层，永不遮挡
    Rectangle{
        z: 999  // 层级优先级最高，确保按钮在所有内容最上方
        visible: false
        width: 100; height: 50
        color: "#50303030"
        anchors{ right: parent.right; rightMargin:10; bottom: parent.bottom; bottomMargin:10 }
        radius:10
        Text{ anchors.centerIn: parent; font.pixelSize:24; color:"white"; text:"clear" }
        MouseArea{ 
            anchors.fill: parent; 
            onClicked: {
                resetAllData()
                isClicked = false;
                console.log("🔄 手动点击重置，数据清空+画布刷新完成！")
            } 
        }
    }
}