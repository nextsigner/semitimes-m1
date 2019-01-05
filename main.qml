import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow{
    id: app
    visible:true
    width:300
    height:300
    color: "transparent"
    title: "semitimes m1"
    flags: Qt.platform.os !=='android'?Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint:undefined
    property var logView
    property int a: 0
    property int d: 0
    property int me: 0
    property int h: 0
    property int m: 0
    property int s: 0

    //property var t: ['#1fbc05-#4fec35-#ffffff-#000000-#333333','#2e9afe-white-#ffffff-#000000-#58d3f7','#ff5555-red-#ffffff-#000000-#ffffff','gray-black-#ffffff-#000000-#cccccc']
    property var t:[]
    property color c1: "#2E9AFE"
    property color c2: "white"
    property color c3: "white"
    property color c4: "black"
    property color c5: "#58d3f7"
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}

    Settings{
        id: appSettings
        category:'conf-semitimes-year'
        property real radnh:0.8
        property real radlm:0.8
        property int w: 300
        property int h: 300
        property int x: 300
        property int y: 300
        property int anioMin
        property int tema
        property string lt
    }

    Rectangle{
        id: reloj
        width: app.width<app.height?app.width:app.height
        height: width
        radius: width*0.5
        color: app.c5
        border.width:2
        border.color: app.c1
        anchors.centerIn: parent
        clip:true
        antialiasing: true

        MouseArea{
            id: max
            property variant clickPos: "1,1"
            property bool presionado: false
            anchors.fill: parent
            enabled: Qt.platform.os!=='android'
            onDoubleClicked: {
                Qt.quit()
            }
            onReleased: {
                presionado = false
                appSettings.x = app.x
                appSettings.y = app.y
            }
            onPressed: {
                presionado = true
                clickPos  = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                if(presionado){
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    app.x += delta.x;
                    app.y += delta.y;
                }
            }
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(app.width<150){
                        return
                    }
                    app.width += wheel.angleDelta.y / 120
                    app.height = app.width
                    reloj.width = app.width
                    reloj.height = app.width
                }
                if(app.width<=149){
                    app.width=151
                    app.height = app.width
                }
                appSettings.x = app.x
                appSettings.y = app.y
                appSettings.w = app.width
                appSettings.h = app.height
            }
        }

        MouseArea{
            id: maxAndroid
            width: parent.width*0.25
            height: width
            anchors.centerIn: parent
            onClicked: {
                xControls.width=xControls.parent.width*0.65
                xControls.visible=true
            }
        }





        Rectangle{
            id:capaAnio
            width:  !parent.width % 2 ? parent.width : parent.width-3
            height: width
            anchors.centerIn: parent
            rotation: 360/24
            color: 'transparent'
            radius: width*0.5
            antialiasing: true
            clip: true
            // smooth: true

            Item{
                id: agujaAnio
                //color: "#ccc"
                //height: !parent.height-(parent.height*xAnio.d*2)  % 2 ? parent.height-(parent.height*xAnio.d*2): parent.height-(parent.height*xAnio.d*2)+1
                //width: !parent.width-(parent.width*xAnio.d)  % 2 ? parent.width-(parent.width*xAnio.d) : parent.width-(parent.width*xAnio.d)
                width:  !xAnio.width*xAnio.d  % 2 ? xAnio.width*xAnio.d : xAnio.width*xAnio.d+1
                height: parent.height
                anchors.centerIn: parent
                clip:true
                Rectangle{
                    width:  parent.width
                    height: width*2
                    antialiasing: true
                    //visible: false
                    radius: width*0.5
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00;
                            color: app.c1;
                        }
                        GradientStop {
                            position: 0.60;
                            color: app.c2;
                        }
                        GradientStop {
                            position: 1.00;
                            color: app.c2;
                        }
                    }
                    border.width: 2
                    border.color: app.c1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 0-width
                }

            }

            Rectangle{
                id:xAnio
                width: !parent.width % 2 ? parent.width : parent.width-1
                height:width
                color: "transparent"
                antialiasing: true
                radius: width*0.5
                property int cc: 12
                property real d: 0.1
                Repeater{
                    model:12
                    Item{
                        width: !parent.width*parent.d % 2 ? (parent.width*parent.d)+1 : parent.width*parent.d
                        height: parent.height
                        anchors.centerIn: parent
                        rotation: (360/12)*index
                        Rectangle{
                            width:parent.width
                            height:width
                            color: parseInt(modelData)+18===app.a?'transparent':app.c1
                            anchors.top: parent.top
                            anchors.topMargin: parent.width*0.05
                            radius: width*0.5
                            opacity: parseInt(modelData)+18===app.a?1.0:0.75
                            antialiasing: true
                            Text{
                                text:parseInt(modelData)+appSettings.anioMin
                                font.pixelSize: parent.width*0.6
                                anchors.centerIn: parent
                                color: parseInt(modelData)+18===app.a?app.c5:app.c5
                                rotation: 0-((360/12)*index)-360/24
                            }
                        }
                    }
                }
            }





        }
        Rectangle{
            id:xAgujaMes
            width:  !parent.width % 2 ? parent.width : parent.width-3
            height: width
            anchors.centerIn: parent
            color: 'transparent'
            radius: width*0.5
            antialiasing: true
            clip: true

            Rectangle{
                id: agujaMes
                //height: !parent.height-(parent.height*xMes.d*2)  % 2 ? parent.height-(parent.height*xMes.d*2): parent.height-(parent.height*xMes.d*2)+1
                color: 'transparent'
                height: parent.height
                width: !capaMes.width*xMes.d % 2 ? capaMes.width*xMes.d : capaMes.width*xMes.d+1
                anchors.centerIn: parent
                clip: true
                Rectangle{
                    width:  !capaMes.width*xMes.d % 2 ? capaMes.width*xMes.d : capaMes.width*xMes.d+1
                    height: width*4
                    antialiasing: true
                    radius: width*0.5
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00;
                            color: app.c1;
                        }
                        GradientStop {
                            position: 0.60;
                            color: app.c2;
                        }
                        GradientStop {
                            position: 1.00;
                            color: app.c2;
                        }
                    }
                    border.width: 2
                    border.color: app.c1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom:  parent.top
                    anchors.bottomMargin: 0-width*2
                }
            }

        }


        Item{
            id:capaMes
            width: capaAnio.width-(capaAnio.width*xAnio.d)
            height: width
            anchors.centerIn: parent
            clip: true
            //visible:false
            /*Rectangle{
                width: !parent.width-(capaAnio.width*xAnio.d) % 2 ? parent.width-(capaAnio.width*xAnio.d)-1 : parent.width-(xAnio.width*xAnio.d)
                height: width
                color: "black"
                opacity: 0.6
                radius: width*0.5
                anchors.centerIn: parent
            }*/


            Rectangle{
                id:xMes
                width: parent.width
                height:width
                color: "transparent"
                property int cc: 12
                property real d: 0.06
                Repeater{
                    model:12
                    Item{
                        width: !parent.width*parent.d % 2 ? (parent.width*parent.d)+1 : parent.width*parent.d
                        height: parent.height
                        anchors.centerIn: parent
                        rotation: (360/12)*index
                        Rectangle{
                            width:parent.width
                            height:width
                            color: parseInt(modelData)===app.me?'transparent':app.c1

                            radius: width*0.5
                            opacity: parseInt(modelData)===app.me?1.0:0.75
                            Text{
                                text:parseInt(modelData)+1
                                font.pixelSize: parent.width*0.6
                                anchors.centerIn: parent
                                color: parseInt(modelData)===app.me?app.c5:app.c5
                                rotation: 0-((360/12)*index)
                            }
                        }
                    }
                }
            }




        }




        Item{
            id:capaDias
            width: capaMes.width-(capaMes.width*xMes.d*3)
            height: width
            anchors.centerIn: parent
            property real d: 0.1

            Rectangle{
                color: 'transparent'
                width: xDias.width
                height: width
                anchors.centerIn: parent
                border.width: xDias.width*xDias.d
                //border.width: !xDias*xDias.d*0.5  % 2 ? xDias*xDias.d*0.5: xDias*xDias.d*0.5+1
                border.color: app.c1
                radius: width*0.5
                opacity: 0.75
            }
            Rectangle{
                id:bordeDia
                color: 'transparent'
                width: xDias.width-(xDias.width*xDias.d*2)
                height: width
                anchors.centerIn: parent
                border.width: !xDias.width*xDias.d*0.04  % 2 ? xDias.width*xDias.d*0.04: xDias.width*xDias.d*0.04+1
                border.color: app.c2
                radius: width*0.5
            }

            Rectangle{
                id:xDias
                width: parent.width
                height:width
                color: "transparent"
                property int cc: 0
                property real d: 0.06
                function clear(){
                    for(var i=0;i<children.length;i++){
                        children[i].destroy(1)
                    }
                }



            }

            Rectangle{
                color: app.c5
                width: bordeDia.width-(bordeDia.border.width*2)
                height: width
                anchors.centerIn: parent
                radius: width*0.5
            }

            Item{
                id: agujaDias
                height: !parent.height-(parent.height*xDias.d*2)  % 2 ? parent.height-(parent.height*xDias.d*2): parent.height-(parent.height*xDias.d*2)+1
                width: !parent.width*0.02 % 2 ? parent.width*0.02 : parent.width*0.02+1
                anchors.centerIn: parent
            }
        }
        Item{
            id:capaHoras
            width: capaDias.width-(capaDias.width*capaDias.d*2)
            height: width
            anchors.centerIn: parent
            property real d: 0.1
            Rectangle{
                id: xHoras
                width:!parent.width % 2 ? parent.width : parent.width+1
                height:width
                anchors.centerIn: parent
                color: "transparent"
                Repeater{
                    model:["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
                    Item{
                        width: parent.width*capaHoras.d
                        height: parent.height
                        anchors.centerIn: parent
                        rotation: (360/12)*index
                        Rectangle{
                            width:parent.width
                            height:width
                            color: app.c1
                            border.color: app.c2
                            border.width: 1
                            radius: width*0.5
                            Text{
                                text:modelData
                                font.pixelSize: parent.width*0.6
                                anchors.centerIn: parent
                                color: app.c5
                                rotation: 0-((360/12)*index)
                            }
                        }
                    }
                }
            }

            Rectangle{
                id: agujaHoras
                color: "transparent"
                height: parent.height*0.6
                width: !parent.width*0.02 % 2 ? parent.width*0.02 : parent.width*0.02+1
                anchors.centerIn: parent
                Rectangle{
                    width: parent.width
                    height: parent.height*0.5
                    color: app.c2
                    antialiasing: true
                }
            }

        }

        Rectangle{
            id:xMH
            //width:!app.width*appSettings.radnm % 2 ? app.width*appSettings.radnm : app.width*appSettings.radnm+1
            //width: reloj.width*appSettings.radlm
            width: capaHoras.width-(capaHoras.width*capaHoras.d*2.25)
            height:width
            anchors.centerIn: reloj
            color: "transparent"
            //visible:false

            Repeater{
                model:60
                Item{
                    width: !reloj.width*0.005 % 2 ? (reloj.width*0.005)+1 : reloj.width*0.005
                    height: parent.height
                    anchors.centerIn: parent
                    rotation: (360/60)*index
                    Rectangle{
                        width: parent.width
                        height: parent.height*0.02
                        color: app.c2
                        anchors.horizontalCenter: parent.horizontalCenter
                        antialiasing: true
                    }
                }
            }
            Rectangle{
                id: agujaMinutos
                color: "transparent"
                height: parent.height*0.9
                width: !parent.width*0.02 % 2 ? parent.width*0.02 : parent.width*0.02+1
                anchors.centerIn: parent
                antialiasing: true
                Rectangle{
                    width: parent.width/2
                    height: parent.height*0.5
                    color: app.c2
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                }
            }
            Rectangle{
                id: agujaSegundos
                color: "transparent"
                height: parent.height
                width: !parent.width*0.01 % 2 && parent.width*0.01>0 ? parent.width*0.01 : parent.width*0.01+1
                anchors.centerIn: parent
                Rectangle{
                    width: parent.width/2
                    height: parent.height*0.5
                    color: "red"
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                }
            }
        }
        Rectangle{
            id: centro
            color: app.c1
            height: width
            width: parent.width*0.05
            radius: width*0.5
            anchors.centerIn: parent
        }
        Rectangle{
            id: xControls
            color: app.c5
            border.width: 1
            border.color: app.c2
            height: width
            width: !visible?0:parent.width*0.65
            visible: false
            radius: width*0.5
            anchors.centerIn: parent
            onWidthChanged:{
                if(width===0){xControls.visible=false}
            }
            Behavior on width {
                NumberAnimation {
                    target: xControls
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            property var a: ['\uf0a8','\uf2d2','\uf011','\uf1fc', 'R']
            Repeater{
                model:5
                Item{
                    width: parent.width*0.2
                    height: parent.height*0.8
                    anchors.centerIn: parent
                    rotation: (360/5)*index
                    Boton{
                        t: xControls.a[index]
                        w: parent.width
                        h: w
                        r: w*0.5
                        b: app.c1
                        c: app.c5
                        s: w*0.7
                        rotation: 0-(360/5)*index
                        onClicking:{
                            xControls.run(index)
                        }
                    }
                }
            }
            function run(index){
                if(index===0){
                    xControls.width=0
                }
                if(index===1){
                    var j=''+appsDir+'/unik-tools/main.qml'
                    unik.cd(''+appsDir+'/unik-tools')
                    console.log('Loading '+j)
                    engine.load(j)
                    app.close()
                }
                if(index===2){
                    Qt.quit()
                }
                if(index===3){
                    nextTema()
                }
                if(index===4){
                    setRTema()
                    btnGR.enabled=true
                }
            }
            Boton{
                id: btnGR
                opacity: enabled?1.0:0.5
                enabled: false
                t: '\uf0c7'
                w: parent.width*0.2
                h: w
                r: w*0.5
                b: app.c1
                c: app.c5
                s: w*0.7
                anchors.centerIn: parent
                onClicking:{
                    var nc = ','+app.c1+'-'+app.c2+'-'+app.c3+'-'+app.c4+'-'+app.c5+''
                    appSettings.lt = appSettings.lt+nc
                    btnGR.enabled = false

                }
            }
            Boton{
                id: btnBC
                visible: !btnGR.enabled
                t: '\uf0c7'
                w: parent.width*0.2
                h: w
                r: w*0.5
                b: app.c1
                c: app.c5
                s: w*0.7
                anchors.centerIn: parent
                onClicking:{
                    if(app.t[appSettings.tema]!=='#1fbc05-#4fec35-#ffffff-#000000-#333333'){
                        var nc = ''+appSettings.lt
                        console.log(nc)
                        var nc2=nc.replace(','+app.t[appSettings.tema], '')
                        console.log(nc2)
                        appSettings.lt = nc2
                        //btnBC.enabled = false
                        nextTema()
                    }
                }
                Text {
                    text: '<b>X</b>'
                    font.pixelSize: parent.width*0.8
                    color: 'red'
                    anchors.centerIn: parent
                }
            }
        }
    }

    Timer{
        id: t
        running: true
        repeat: true
        interval: 1000
        onTriggered:{
            tic()
        }
    }
    function tic(){
        //var d = app.d0
        var d = new Date(Date.now())
        //d.setHours(d.getHours()+1)//Adelanta de a una hora
        //d.setFullYear(d.getFullYear()+1)//Adelanta de a un año
        //d.setMonth(d.getMonth()+1)//Adelanta de a un mes

        app.a=d.getFullYear()-2000
        app.me=d.getMonth()
        app.d=d.getDate()

        app.h=d.getHours()

        app.m=d.getMinutes()
        app.s=d.getSeconds()

        if(app.h===0){
            setDias()
        }
        //console.log(app.me)
        if(app.me===0){
            if(app.a===appSettings.anioMin+12){
                appSettings.anioMin+=12
            }

        }

        if(agujaSegundos.rotation>353&&agujaSegundos.rotation<360){
            agujaSegundos.rotation = 0
        }else{
            agujaSegundos.rotation = (360/60)*app.s
        }
        var prm = agujaSegundos.rotation/360*100
        var prm2 = (60/100*prm)/60
        agujaMinutos.rotation =(360/60)*app.m + (360/60)*(prm2)

        var prh = agujaMinutos.rotation/360*100
        var prh2 = (12/100*prh)/12
        agujaHoras.rotation = (360/12)*app.h + (360/12)*(prh2)

        var prh = agujaHoras.rotation/360*100
        var prh2 = (xDias.cc/100*prh)/xDias.cc
        agujaDias.rotation = (360/xDias.cc)*(d.getDate()-1)
        agujaMes.rotation = (360/12)*(d.getMonth())
        agujaAnio.rotation = (360/12)*(d.getFullYear()-2000-appSettings.anioMin)
    }
    property var d0


    function setDias() {
        xDias.clear()
        //var d=new Date(Date.now())
        var d = app.d0
        var ma=d.getMonth()+1
        var an=d.getFullYear()

        var di=28
        var f = new Date(an,ma-1,di);
        while(f.getMonth()==ma-1){
            di++;
            f = new Date(an,ma-1,di);
        }
        xDias.cc=di-1

        for(var i=0;i<di-1;i++){
            var c='import QtQuick 2.0\nItem{\n'
                    +' width: !parent.width*parent.d % 2 ? (parent.width*parent.d)+1 : parent.width*parent.d\n'
                    +' height: parent.height\n'
                    +'anchors.centerIn: parent\n'
                    +'rotation: (360/'+parseInt(di-1)+')*'+i+'\n'
                    +'Rectangle{\n'
            //+'   rotation: 0-(360/'+parseInt(di-1)+')*'+i+'\n'
                    +'   visible: parseInt('+parseInt(i+1)+')===app.d\n'
                    +'   width: parent.width\n'
                    +'    height: parent.width*2\n'
                    +'    radius: height*0.5\n'
                    +'    color: parseInt('+parseInt(i+1)+')===app.d?app.c5:app.c1\n'
                    +'    opacity: parseInt('+parseInt(i+1)+')===app.d?1.0:0.75\n'
                    +'   anchors.horizontalCenter: parent.horizontalCenter\n'
                    +'   antialiasing: true\n'
                    +'   border.width: !xDias.width*xDias.d*0.04  % 2 ? xDias.width*xDias.d*0.04: xDias.width*xDias.d*0.04+1\n'
                    +'    border.color:app.c2\n'
                    +'}\n'
                    +'Rectangle{\n'
                    +'   rotation: 0-(360/'+parseInt(di-1)+')*'+i+'\n'
                    +'   width: parent.width\n'
                    +'   height: width\n'
                    +'   radius: width*0.5\n'
                    +'   color: parseInt('+parseInt(i+1)+')===app.d?"transparent":app.c1\n'
                    +'   opacity: parseInt('+parseInt(i+1)+')===app.d?1.0:0.75\n'
                    +'   anchors.horizontalCenter: parent.horizontalCenter\n'
                    +'   antialiasing: true\n'
                    +'   Text{\n'
                    +'      text:""+'+parseInt(i+1)+'\n'
                    +'      color: parseInt('+parseInt(i+1)+')===app.d?app.c2:app.c5\n'
                    +'      font.pixelSize:parent.width*0.5\n'
                    +'      anchors.centerIn: parent\n'
                    +'   }\n'
                    +'}\n'
                    +'}'
            var n = Qt.createQmlObject(c, xDias, 'cd')
        }
    }
    function nextTema(){
        if(appSettings.tema<app.t.length-1){
            appSettings.tema++
        }else{
            appSettings.tema=0
        }
        setTema()
    }
    function setTema(){
        app.t = appSettings.lt.split(',')
        var m0=(''+app.t[appSettings.tema]).split('-')
        app.c1= m0[0]
        app.c2= m0[1]
        app.c3= m0[2]
        app.c4= m0[3]
        app.c5= m0[4]
    }
    function setRTema(){
        app.c1= getRandomColor()
        app.c2= getRandomColor()
        app.c3= getRandomColor()
        app.c4= getRandomColor()
        app.c5= getRandomColor()
    }
    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
    Component.onCompleted:{
        unik.setProperty("logViewVisible", true)
        if(appSettings.lt===''){
            appSettings.lt = '#1fbc05-#4fec35-#ffffff-#000000-#333333,#2e9afe-white-#ffffff-#000000-#58d3f7,#ff5555-red-#ffffff-#000000-#ffffff,gray-black-#ffffff-#000000-#cccccc'
        }
        //appSettings.lt = '#1fbc05-#4fec35-#ffffff-#000000-#333333,#2e9afe-white-#ffffff-#000000-#58d3f7,#ff5555-red-#ffffff-#000000-#ffffff,gray-black-#ffffff-#000000-#cccccc'
        setTema()
        app.d0 = new Date(Date.now())
        //app.d0=new Date(2018,0,30,0,0,0) 30 de enero de 2018 00:00:00hs
        //app.d0=new Date(2018,0,31,22,0,0)
        if(appSettings.anioMin===0||appSettings.anioMin<18){
            console.log("Reloj iniciado por primera vez")
            appSettings.anioMin = app.d0.getFullYear()-2000
        }
        appSettings.anioMin = app.d0.getFullYear()-2000
        setDias()
        if(Qt.platform.os!=='android'){
            appSettings.radnh = 0.98
            appSettings.radlm = 0.8
            app.width = appSettings.w
            app.height = appSettings.h
            app.x = appSettings.x
            app.y = appSettings.y
        }
        tic()
    }
}
