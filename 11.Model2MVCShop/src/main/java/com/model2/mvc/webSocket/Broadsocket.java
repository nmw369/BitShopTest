package com.model2.mvc.webSocket;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;





@ServerEndpoint("/chat2")
public class Broadsocket {
	
	 private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	 public Broadsocket() {
		 System.out.println("Broadcast!!!");
	 }
	 
		 @OnOpen // �� ������ ���ӵǸ� ������ �ִ´�
		 public void onOpen(Session session) {
	
		  System.out.println(session);
		  clients.add(session);
		 }

		 @OnMessage//�� �������� ���� �޼����� ���� ȣ���Ѵ�.
		 public void onMessage(String message, Session session) throws IOException {
		  System.out.println(message);
		  if(message.contains("\\")) {
		  
		  String fileName = message.substring(message.lastIndexOf("\\")+1,message.lastIndexOf(".")+4);
		  String path = message.substring(0,message.indexOf(fileName));
		  System.out.println(path+"::::��� ���");
		  
		  File file = new File(path+fileName);
		  byte[] bytes = new byte[(int)file.length()];
		  DataInputStream dateInput = new DataInputStream(new FileInputStream(file));
		  dateInput.readFully(bytes);
		  ByteBuffer buf = ByteBuffer.wrap(bytes);
		  
		  session.getBasicRemote().sendBinary(buf);
		  
		  }
		  //�ش� �������� �޼����� ������.
		  synchronized (clients) {
		   	  for (Session client : clients) {
				  if (!client.equals(session)) {
					  client.getBasicRemote().sendText(message);
					  //�����Դ� �Ⱥ��̰� ���濡�� ������ ���� ȭ�鿡���� ����
					  	
				  }
			  }
		  	}
		 }
	
		
		 @OnClose//������ ������ �ൿ
		 public void onClose(Session session) {

		  clients.remove(session);
		 }
}