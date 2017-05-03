package com.ukefu.webim.util.server;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.corundumstudio.socketio.SocketIONamespace;
import com.corundumstudio.socketio.SocketIOServer;
import com.ukefu.core.UKDataContext;
import com.ukefu.webim.util.server.handler.AgentEventHandler;
import com.ukefu.webim.util.server.handler.EntIMEventHandler;
import com.ukefu.webim.util.server.handler.IMEventHandler;
  
@Component  
public class ServerRunner implements CommandLineRunner {  
    private final SocketIOServer server;
    private final SocketIONamespace imSocketNameSpace ;
    private final SocketIONamespace agentSocketIONameSpace ;
    private final SocketIONamespace entIMSocketIONameSpace ;
    
    @Autowired  
    public ServerRunner(SocketIOServer server) {  
        this.server = server;  
        imSocketNameSpace = server.addNamespace(UKDataContext.NameSpaceEnum.IM.getNamespace())  ;
        agentSocketIONameSpace = server.addNamespace(UKDataContext.NameSpaceEnum.AGENT.getNamespace()) ;
        entIMSocketIONameSpace = server.addNamespace(UKDataContext.NameSpaceEnum.ENTIM.getNamespace()) ;
    }
    
    @Bean(name="imNamespace")
    public SocketIONamespace getIMSocketIONameSpace(SocketIOServer server ){
    	imSocketNameSpace.addListeners(new IMEventHandler(server));
    	return imSocketNameSpace  ;
    }
    
    @Bean(name="agentNamespace")
    public SocketIONamespace getAgentSocketIONameSpace(SocketIOServer server){
    	agentSocketIONameSpace.addListeners(new AgentEventHandler(server));
    	return agentSocketIONameSpace;
    }

    @Bean(name="entimNamespace")
    public SocketIONamespace getEntIMSocketIONameSpace(SocketIOServer server){
    	entIMSocketIONameSpace.addListeners(new EntIMEventHandler(server));
    	return entIMSocketIONameSpace;
    }

    public void run(String... args) throws Exception { 
        server.start();  
        UKDataContext.setIMServerStatus(true);	//IMServer 启动成功
    }  
}  