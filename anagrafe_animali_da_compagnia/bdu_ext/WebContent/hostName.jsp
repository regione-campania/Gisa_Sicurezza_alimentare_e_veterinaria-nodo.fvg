 <%String PUBLIC_URL  = java.net.InetAddress.getByName("srvBDUW").getHostAddress();
 java.net.InetAddress iadd = java.net.InetAddress.getByName(PUBLIC_URL);
  //out.println("Alias: "+iadd.getHostName());
 %>
<b>GENERATO DA:</b> <i><%= iadd.getHostName()%></i>