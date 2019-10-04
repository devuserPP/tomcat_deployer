# tomcat_deployer
<h3>Quick solution for deploy war file</h3>



<p><h4>Installation Prerequisites:</h4></p>

<b>Install Docker Community Edition (CE)</b>
documentation: 
https://docs.docker.com/install/


<b>Install Git client</b> 
https://git-scm.com/downloads/guis/</br>



<h4>Tested version:</h4>
<ul>
<li>Docker CE: 18.09.2</li>
<li>Tomcat: 8.5.46</li>
<li>Centos image: Centos:Centos8</li>

<h4>Installation:</h4>
<p><code>$cd /</code> </br>
<code>$mkdir my_project</code></br>
<code>$cd my_project</code></br>
<code>$git clone https://github.com/devuserPP/tomcat_deployer.git</code></br>
<code>$cd tomcat_deployer</code></br>

save your war file into <a href="https://github.com/devuserPP/tomcat_deployer/tree/master/target">target folder</a>
<h4>Started by script:</h4>
<code>$chmod +x ./start.sh</code></br>
<code>$./start.sh</code></br>
<BR>
or if you need change something in
<a href="https://github.com/devuserPP/tomcat_deployer/blob/master/docker.ver">docker.ver</a>. and rebuild it </br>
<code>$./start.sh rebuild</code></br>
</p>

<HR>

<b> Tomcat should start and could be accesible on http://localhost:3333 </b>

<h4>User name and password is always:</h4>
<b>tomcat:tomcat</b>

<h4>for updating <a href="https://github.com/devuserPP/tomcat_deployer/blob/master/docker.ver">docker.ver</a>.</h4>
<ul>
<li><a href="https://www-eu.apache.org/dist/tomcat/tomcat-8/"><code>TOMCAT_VERSION:</code></a></li>

<li><a href="https://hub.docker.com/_/centos/?tab=tags"><code>MY_DOCKER_IMAGE_FROM:</code></a></li>

</ul>



