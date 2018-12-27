<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>ä�ù����Ͼ��ε�</title>
</head>
<body>
	
	
	<textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
	
     <br/>
     <input id="inputMessage" type="text" onkeypress="if(event.keyCode == 13){ send()};"/>
     <input type="submit" value="����" onclick="send()" />

    <input id="file" type="file" >
    
    <input id="send" type="button" value="send">
</body>
<script type="text/javascript">
        var textarea = document.getElementById("messageWindow");
        var serverIP = "ws://"+"192.168.0.28"+":8080/chat";
        var webSocket = new WebSocket(serverIP);
        var inputMessage = document.getElementById('inputMessage');
        
        webSocket.binaryType="arraybuffer";
        
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
    		textarea.value += event.data + "\n";
    	}else if('${user.role}'=="admin"){
    		textarea.value += event.data + "\n";	
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
        textarea.value += "�� : " + inputMessage.value + "\n";
        webSocket.send("${user.userId}:"+inputMessage.value);
        inputMessage.value = "";
    	}else if('${user.role}'=="admin"){
    		textarea.value += "�� : " + inputMessage.value + "\n";
            webSocket.send("${user.userId}:"+inputMessage.value);
            inputMessage.value = "";	
    	}
    	
    }
    
    function sendFile(){
        var file = document.getElementById('file').files[0];
        webSocket.send('filename:'+file.name);
        alert('���������� �����մϴ�.');
        
        
        var reader = new FileReader();
        var rawData = new ArrayBuffer();            

        reader.loadend = function() {

        }
        
        reader.onload = function(e) {
            rawData = e.target.result;
            webSocket.send(rawData);
            alert("���� ������ �Ϸ� �Ǿ����ϴ�.")
           
        }

        reader.readAsArrayBuffer(file);
    }

    function addEvent(){
        document.getElementById("send").addEventListener("click", sendFile, false);
    }
    
    window.addEventListener("load", addEvent, false);
    
    
    
  </script>
  

</html>