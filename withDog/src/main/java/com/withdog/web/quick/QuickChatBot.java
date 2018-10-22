package com.withdog.web.quick;

import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;





@ServerEndpoint("/chat")
public class QuickChatBot {
	
	 /*DataInputStream dateInput;*/
	    String path = "C:\\Users\\Bit\\Desktop";
	    public static int  limit=0;
	    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	    Random random = new Random();
	    /*private static int i=0;*/
	    // �޼����� ������ ȣ��ȴ�.
	    @OnMessage
	    public void onMessage(Session session, String message) throws Exception {
	        System.out.println("�޼���Ȯ��");
	    	System.out.println(message);

	        // Ŭ���̾�Ʈ���� ������ �����ٴ� ��ȣ�� "end" ���ڿ��� ������.
	        // msg�� end�� �ƴ϶�� ���Ϸ� ����� ��Ʈ���� ����.
	        if(message.contains("\\")){
	            
	            // Ŭ���̾�Ʈ���� ������ �����ϱ��� �����̸��� "file name:aaa.aaa" �������� ������.
	            String fileName = message.substring(message.indexOf(":")+1);
	            System.out.println(fileName);
	            File file = new File(path + fileName);
	            byte[] bytes = new byte[(int)file.length()];
	            try {
/*	                dateInput = new DataInputStream(new FileInputStream(file));
	                dateInput.readFully(bytes);*/
	            } catch (Exception e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	            
	        // msg �� end�� �Դٸ� ������ �Ϸ�Ǿ����� �˸��� ��ȣ�̹Ƿ� outputstream �� �ݾ��ش�.
	        }else{
	        	
	        	synchronized (clients) {
	  		   	  for (Session client : clients) {
	  		   		  System.out.println("client : "+client);
	  				  if (!client.equals(session)) {
	  					  
	  					  client.getBasicRemote().sendText(message);
	  					  //�����Դ� �Ⱥ��̰� ���濡�� ������ ���� ȭ�鿡���� ����
		  			    	if(message.contains("����")) {
		  			    		System.out.println("������� ���Դ��־ ���� ����");
		  			    		clients.clear();
		  			    	}
	  				  }
	  			  }
	  		  	}
	        }	
	            
	    }
	    
	    // ���̳ʸ� �����Ͱ� ���ԵǸ� ȣ��ȴ�.
	    @OnMessage
	    public void binaryMessage(byte[] bytes, boolean last, Session session) {
	    	System.out.println("�����Ϳ�");
	    	System.out.println(bytes.length+":::---");
	    	
	    	try {
	    	DataOutputStream copyfile = new DataOutputStream(new FileOutputStream("\\\\localhost\\Users\\Bit\\Desktop\\chatTing.jpg",true));
	    	
	    	//IP�� ���� ������ ���� ������ �� �ִ�.
	    	copyfile.write(bytes);
		    copyfile.close();
		    if (last) {
		        		 
		        //�̸��� �ٲ� ������ ���丮 ����
		        final String folder = "C:\\Users\\Bit\\Desktop\\test\\";
		        File file = new File(folder);
		         
		        //�ش� ���丮�� �����ϴ��� �˻�
		        if(!file.isDirectory()){
		            System.exit(-1);
		        }
		        
		        Map<String, String> map = new HashMap<String, String>();
		        
		        //���ϵ��� ����Ʈ�� �о�´�.
		           
		        String[] fileList = file.list();
		        File[] Files = file.listFiles();
		        for(int i=0; i<fileList.length; i++){
		        	//map.put("�������ϸ�", "�ٲ���� ���ϸ�");
			        map.put("test.jpg", "test"+fileList.length+".jpg");
		            for(int j=0; j<map.size(); j++){
		                if(map.containsKey(fileList[i])){ //map�� �̸��� �ִ��� (������ TRUE, ������ FALSE)
		                    File newFileName = new File(folder + "/" + map.get(fileList[i])); //�ִٸ� �ش��ϴ� value��(�ٲ���� �̸�)�� ���´�.
		                    if(Files[i].renameTo(newFileName)){
		                        System.out.println(i + "��° ���ϸ� : " + fileList[i] + "===> ���� ����");
		                        map.remove(fileList[i]); //���漺���� map���
		                        break;
		                    }
		                }
		            }
		        }
		    	/* dateInput.close();*/
	            System.out.println("����-->Ŭ���̾�Ʈ ���̳ʸ� ���ۿϷ�");
	           
	        }   
	            } catch (IOException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	        }

	    @OnOpen
	    public void open(Session session) {
	        System.out.println("WebSocket File Server Open......");
	        limit++;
	        System.out.println(limit);
	        if(limit<3) {
	        	
	        clients.add(session);
	        }
	    }

	    @OnError
	    public void error(Session session, Throwable t) {
	        System.out.println("error.......");
	    }

	    @OnClose
	    public void closedConnection(Session session) {
	    	limit=0;
	    	System.out.println(limit);
	    	clients.remove(session);
	    	System.out.println("��������........");
	    }
}