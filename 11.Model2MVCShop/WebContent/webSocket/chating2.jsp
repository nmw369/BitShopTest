<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
<head>
<!-- ȭ�� ���� -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta charset="UTF-8">
    <title>Testing websockets</title>
</head>
<body>
    <fieldset>
        <textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
        <br/>
        <input id="inputMessage" type="text" onkeypress="if(event.keyCode == 13){ send()};"/>
        <input type="submit" value="����" onclick="send()" />
        <br>
        <input type="file" id="fileName">
	    <input type="button" value="Upload" onclick="sendFile()" />
    </fieldset>
    
    
</body>
    <script type="text/javascript">
        var textarea = document.getElementById("messageWindow");
        var serverIP = "ws://"+"192.168.0.28"+":8080/chat";
        var webSocket = new WebSocket(serverIP);
        var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
      onError(event)
    };
    webSocket.onopen = function(event) {
      onOpen(event)
    };
    webSocket.onmessage = function(event) {
      onMessage(event)
    };
    function onMessage(event) {
    	
    	if('${user.role}'=="user"){
    		textarea.value +=  "���"+":z " + event.data + "\n";
    	}else if('${user.role}'=="admin"){
    		textarea.value +=  "${clientIP}"+":x " + event.data + "\n";	
    	}
        
        
        
    }
    function onOpen(event) {
    	if('${user.userId}'!=null){
        textarea.value += "����Ǿ����ϴ�.\n";
    	}else{
    	textarea.value += "�α��ν� �̿밡���ѱ���Դϴ�.\n";
    	}
    }
    function onError(event) {
      alert(event.data);
    }
    function send() {
    	if('${user.role}'=="user"){
        textarea.value += "${user.userId}"+" ����1: " + inputMessage.value + "\n";
        webSocket.send(inputMessage.value);
        inputMessage.value = "";
    	}else if('${user.role}'=="admin"){
    		textarea.value += "${user.userId}"+" ����2: " + inputMessage.value + "\n";
            webSocket.send(inputMessage.value);
            inputMessage.value = "";	
    	}
    	
    }
    function sendFile() {
    	alert("����");
        var file = document.getElementById('filename').files[0];
        var reader = new FileReader();
        var rawData = new ArrayBuffer();            

        reader.loadend = function() {

        }
        reader.onload = function(e) {
            rawData = e.target.result;
            ws.send(rawData);
            alert("the File has been transferred.")
        }

        reader.readAsBinaryString(file);

    }
  </script>
</html>