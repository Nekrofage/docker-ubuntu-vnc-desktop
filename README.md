ubuntu-desktop-lxde-vnc-zandronum  
=================================  
  

Build with:  
  
* Docker image to provide HTML5 VNC interface to access Ubuntu 16.04 LXDE desktop environment.  
  
https://github.com/fcwu/docker-ubuntu-vnc-desktop  

See: README.fcwu.docker-ubuntu-vnc-desktop.md

    
* Container for running Zandronum.
  
https://gitlab.com/frozenfoxx/docker-zandronum  
 
See: README.frozenfoxx.docker-zandronum.md

   
* Documentation.
  
1/ Download repository.  
  
```  
$ git clone --recursive -b doom https://github.com/Nekrofage/docker-ubuntu-vnc-doom.git  
```  
  
2/ Push commit.  

```
$ git push -u origin doom  
  

3/ Build Docker image and the volume.  

$ ./createDockerVolume.sh
$ ./buildDockerImage.sh
```

4/ Generate the SSL.  

```
$ ./generateSSL.sh
```

5/ Run the Docker image.  

```
$ ./runDockerImageSSL.sh
```

6/ Launch the browser.  

```
$ launchBrowserSSL.sh
```
