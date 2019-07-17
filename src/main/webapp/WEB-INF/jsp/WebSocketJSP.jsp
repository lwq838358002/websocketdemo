<%--
  Created by IntelliJ IDEA.
  User: Adminstrator
  Date: 2019/7/16
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'index.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-ache">
    <meta http-equiv="ache-control" content="no-ache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,ketword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <script type="text/javascript">
        //判断该浏览器是否支持websocket
        var websocket;
        if ('WebSocket' in window){
            websocket=new WebSocket("ws://localhost:8080/WebSocketTest/"+'${userId}');
            console.log("link sucess");
        }else{
            alert('Not Support websocket');

        }

        //连接发生错误的回调方法
        websocket.onerror=function () {
            setMessageInnerHTML("error");
            
        };

        //连接成功建立的回调方法
        websocket.onopen=function () {
            setMessageInnerHTML("open")
        };

        //接收到消息的回调方法
        websocket.onmessage=function () {
            console.log(event.data);
            setMessageInnerHTML(event.data);
        };

        //连接关闭的回调方法
        websocket.onclose=function () {
            setMessageInnerHTML("close")
        };

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口,server端会抛异常。
        window.onbeforeunload=function () {
            websocket.close();
        };

        //将消息显示在网页上
       function setMessageInnerHTML(innerHTML) {
            document.getElementById('returnMessage').innerHTML+=innerHTML+'<br/>';
        };
        
        function closeWebSocket() {
            websocket.close();
            document.getElementById("send").disabled=true;
            document.getElementById("close").disabled=true;
            document.getElementById("connect").disabled=false;
        };

        //发送消息
        function send() {
            //接收者名称
            var toName=document.getElementById("toName").value;
            if ('' == toName) {
                alert("请填写接收者");
                return;
            }
            //发送消息
            var message=document.getElementById('message').value;
            if ('' == message) {
                alert('请填写发送信息');
                return;
            }
            websocket.send(toName+"-f,t-"+message);
        }

        function connect() {
            //判断当前浏览器是否支持WebSocket
            var websocket;
            if ('WebSocket' in window) {
                websocket=new WebSocket("ws://localhost:8080/WebSocketTest/"+'${userId}');
                console.log("link success");
                document.getElementById("send").disabled=false;
                document.getElementById("close").disabled=false
                document.getElementById("connect").disabled=true;
            }else{
                alert('Not support websocket');
            }

            //连接发生错误的回调方法
            websocket.onerror=function () {
                setMessageInnerHTML("error");
            };

            //连接成功建立的回调方法
            websocket.onopen=function () {
                setMessageInnerHTML("open")
            };

            //接收到消息的回调方法
            websocket.onmessage=function () {
                console.log(event.data);
                setMessageInnerHTML(event.data);
            };

            //连接关闭的回调方法
            websocket.onclose=function () {
                setMessageInnerHTML("close")
            };

            //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口,server端会抛异常。
            window.onbeforeunload=function () {
                websocket.close();
            };
        }
    </script>
</head>
<body>
    webSocket Demo----${userId} <br/>
    发送给谁:<input id="toName" type="text" /><br>
    发送内容<input id="message" type="text" /><br>
    <button id="send" onclick="send()"> Send </button>
    <button id="close" onclick="closeWebSocket()"> Close </button>
    <button id="connect" onclick="connect();" disabled="disabled" > Connect </button>
    <div id="returnMessage"></div>
</body>
</html>
