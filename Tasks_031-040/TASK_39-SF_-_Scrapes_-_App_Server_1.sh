
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 39 - SupportFile - Install and Configure Tomcat Server


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
sudo su -
******[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# sudo yum install -y tomcatLoaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
 * base: mirror.23media.com
 * extras: mirror.23media.com
 * updates: mirror.alpix.eu
Resolving Dependencies
--> Running transaction check
---> Package tomcat.noarch 0:7.0.76-12.el7_8 will be installed
--> Processing Dependency: tomcat-lib = 7.0.76-12.el7_8 for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: java >= 1:1.6.0 for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: apache-commons-pool for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: apache-commons-logging for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: apache-commons-dbcp for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: apache-commons-daemon for package: tomcat-7.0.76-12.el7_8.noarch
--> Processing Dependency: apache-commons-collections for package: tomcat-7.0.76-12.el7_8.noarch
--> Running transaction check
---> Package apache-commons-collections.noarch 0:3.2.1-22.el7_2 will be installed
--> Processing Dependency: jpackage-utils for package: apache-commons-collections-3.2.1-22.el7_2.noarch
---> Package apache-commons-daemon.x86_64 0:1.0.13-7.el7 will be installed
---> Package apache-commons-dbcp.noarch 0:1.4-17.el7 will be installed
--> Processing Dependency: mvn(org.apache.geronimo.specs:geronimo-jta_1.1_spec) for package: apache-commons-dbcp-1.4-17.el7.noarch
---> Package apache-commons-logging.noarch 0:1.1.2-7.el7 will be installed
--> Processing Dependency: mvn(logkit:logkit) for package: apache-commons-logging-1.1.2-7.el7.noarch
--> Processing Dependency: mvn(log4j:log4j) for package: apache-commons-logging-1.1.2-7.el7.noarch
--> Processing Dependency: mvn(avalon-framework:avalon-framework-api) for package: apache-commons-logging-1.1.2-7.el7.noarch
---> Package apache-commons-pool.noarch 0:1.6-9.el7 will be installed
---> Package java-1.8.0-openjdk.x86_64 1:1.8.0.262.b10-0.el7_8 will be installed
--> Processing Dependency: java-1.8.0-openjdk-headless(x86-64) = 1:1.8.0.262.b10-0.el7_8 for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: xorg-x11-fonts-Type1 for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libpng15.so.15(PNG15_0)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjvm.so(SUNWprivate_1.1)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjpeg.so.62(LIBJPEG_6.2)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjava.so(SUNWprivate_1.1)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libasound.so.2(ALSA_0.9.0rc4)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libasound.so.2(ALSA_0.9)(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libXcomposite(x86-64) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: gtk2(x86-64) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: fontconfig(x86-64) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libpng15.so.15()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjvm.so()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjpeg.so.62()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libjava.so()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libgif.so.4()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libasound.so.2()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libXtst.so.6()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libXrender.so.1()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libXi.so.6()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libXext.so.6()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: libX11.so.6()(64bit) for package: 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64
---> Package tomcat-lib.noarch 0:7.0.76-12.el7_8 will be installed
--> Processing Dependency: tomcat-servlet-3.0-api = 7.0.76-12.el7_8 for package: tomcat-lib-7.0.76-12.el7_8.noarch
--> Processing Dependency: tomcat-jsp-2.2-api = 7.0.76-12.el7_8 for package: tomcat-lib-7.0.76-12.el7_8.noarch
--> Processing Dependency: tomcat-el-2.2-api = 7.0.76-12.el7_8 for package: tomcat-lib-7.0.76-12.el7_8.noarch
--> Processing Dependency: ecj >= 1:4.2.1 for package: tomcat-lib-7.0.76-12.el7_8.noarch
--> Running transaction check
---> Package alsa-lib.x86_64 0:1.1.8-1.el7 will be installed
---> Package avalon-framework.noarch 0:4.3-10.el7 will be installed
--> Processing Dependency: xalan-j2 for package: avalon-framework-4.3-10.el7.noarch
---> Package avalon-logkit.noarch 0:2.1-14.el7 will be installed
--> Processing Dependency: jms for package: avalon-logkit-2.1-14.el7.noarch
---> Package ecj.x86_64 1:4.5.2-3.el7 will be installed
---> Package fontconfig.x86_64 0:2.13.0-4.3.el7 will be installed
--> Processing Dependency: freetype >= 2.8-7 for package: fontconfig-2.13.0-4.3.el7.x86_64
--> Processing Dependency: freetype for package: fontconfig-2.13.0-4.3.el7.x86_64
--> Processing Dependency: fontpackages-filesystem for package: fontconfig-2.13.0-4.3.el7.x86_64
--> Processing Dependency: dejavu-sans-fonts for package: fontconfig-2.13.0-4.3.el7.x86_64
--> Processing Dependency: libfreetype.so.6()(64bit) for package: fontconfig-2.13.0-4.3.el7.x86_64
---> Package geronimo-jta.noarch 0:1.1.1-17.el7 will be installed
---> Package giflib.x86_64 0:4.1.6-9.el7 will be installed
--> Processing Dependency: libSM.so.6()(64bit) for package: giflib-4.1.6-9.el7.x86_64
--> Processing Dependency: libICE.so.6()(64bit) for package: giflib-4.1.6-9.el7.x86_64
---> Package gtk2.x86_64 0:2.24.31-1.el7 will be installed
--> Processing Dependency: pango >= 1.20.0-1 for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libtiff >= 3.6.1 for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXrandr >= 1.2.99.4-2 for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: atk >= 1.29.4-2 for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: hicolor-icon-theme for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: gtk-update-icon-cache for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libpangoft2-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libpangocairo-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libpango-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libgdk_pixbuf-2.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libcups.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libcairo.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libatk-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXrandr.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXinerama.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXfixes.so.3()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXdamage.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
--> Processing Dependency: libXcursor.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86_64
---> Package java-1.8.0-openjdk-headless.x86_64 1:1.8.0.262.b10-0.el7_8 will be installed
--> Processing Dependency: tzdata-java >= 2020a for package: 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: copy-jdk-configs >= 3.3 for package: 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: pcsc-lite-libs(x86-64) for package: 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64
--> Processing Dependency: lksctp-tools(x86-64) for package: 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64
---> Package javapackages-tools.noarch 0:3.4.1-11.el7 will be installed
--> Processing Dependency: python-javapackages = 3.4.1-11.el7 for package: javapackages-tools-3.4.1-11.el7.noarch
--> Processing Dependency: libxslt for package: javapackages-tools-3.4.1-11.el7.noarch
---> Package libX11.x86_64 0:1.6.7-2.el7 will be installed
--> Processing Dependency: libX11-common >= 1.6.7-2.el7 for package: libX11-1.6.7-2.el7.x86_64
--> Processing Dependency: libxcb.so.1()(64bit) for package: libX11-1.6.7-2.el7.x86_64
---> Package libXcomposite.x86_64 0:0.4.4-4.1.el7 will be installed
---> Package libXext.x86_64 0:1.3.3-3.el7 will be installed
---> Package libXi.x86_64 0:1.7.9-1.el7 will be installed
---> Package libXrender.x86_64 0:0.9.10-1.el7 will be installed
---> Package libXtst.x86_64 0:1.2.3-1.el7 will be installed
---> Package libjpeg-turbo.x86_64 0:1.2.90-8.el7 will be installed
---> Package libpng.x86_64 2:1.5.13-7.el7_2 will be installed
---> Package log4j.noarch 0:1.2.17-16.el7_4 will be installed
--> Processing Dependency: mvn(javax.mail:mail) for package: log4j-1.2.17-16.el7_4.noarch
---> Package tomcat-el-2.2-api.noarch 0:7.0.76-12.el7_8 will be installed
---> Package tomcat-jsp-2.2-api.noarch 0:7.0.76-12.el7_8 will be installed
---> Package tomcat-servlet-3.0-api.noarch 0:7.0.76-12.el7_8 will be installed
---> Package xorg-x11-fonts-Type1.noarch 0:7.5-9.el7 will be installed
--> Processing Dependency: ttmkfdir for package: xorg-x11-fonts-Type1-7.5-9.el7.noarch
--> Processing Dependency: ttmkfdir for package: xorg-x11-fonts-Type1-7.5-9.el7.noarch
--> Processing Dependency: mkfontdir for package: xorg-x11-fonts-Type1-7.5-9.el7.noarch
--> Processing Dependency: mkfontdir for package: xorg-x11-fonts-Type1-7.5-9.el7.noarch
--> Running transaction check
---> Package atk.x86_64 0:2.28.1-2.el7 will be installed
---> Package cairo.x86_64 0:1.15.12-4.el7 will be installed
--> Processing Dependency: libpixman-1.so.0()(64bit) for package: cairo-1.15.12-4.el7.x86_64
--> Processing Dependency: libGL.so.1()(64bit) for package: cairo-1.15.12-4.el7.x86_64
--> Processing Dependency: libEGL.so.1()(64bit) for package: cairo-1.15.12-4.el7.x86_64
---> Package copy-jdk-configs.noarch 0:3.3-10.el7_5 will be installed
---> Package cups-libs.x86_64 1:1.6.3-43.el7 will be installed
--> Processing Dependency: libavahi-common.so.3()(64bit) for package: 1:cups-libs-1.6.3-43.el7.x86_64
--> Processing Dependency: libavahi-client.so.3()(64bit) for package: 1:cups-libs-1.6.3-43.el7.x86_64
---> Package dejavu-sans-fonts.noarch 0:2.33-6.el7 will be installed
--> Processing Dependency: dejavu-fonts-common = 2.33-6.el7 for package: dejavu-sans-fonts-2.33-6.el7.noarch
---> Package fontpackages-filesystem.noarch 0:1.44-8.el7 will be installed
---> Package freetype.x86_64 0:2.8-14.el7 will be installed
---> Package gdk-pixbuf2.x86_64 0:2.36.12-3.el7 will be installed
--> Processing Dependency: libjasper.so.1()(64bit) for package: gdk-pixbuf2-2.36.12-3.el7.x86_64
---> Package geronimo-jms.noarch 0:1.1.1-19.el7 will be installed
---> Package gtk-update-icon-cache.x86_64 0:3.22.30-5.el7 will be installed
---> Package hicolor-icon-theme.noarch 0:0.12-7.el7 will be installed
---> Package javamail.noarch 0:1.4.6-8.el7 will be installed
---> Package libICE.x86_64 0:1.0.9-9.el7 will be installed
---> Package libSM.x86_64 0:1.2.2-2.el7 will be installed
---> Package libX11-common.noarch 0:1.6.7-2.el7 will be installed
---> Package libXcursor.x86_64 0:1.1.15-1.el7 will be installed
---> Package libXdamage.x86_64 0:1.1.4-4.1.el7 will be installed
---> Package libXfixes.x86_64 0:5.0.3-1.el7 will be installed
---> Package libXinerama.x86_64 0:1.1.3-2.1.el7 will be installed
---> Package libXrandr.x86_64 0:1.5.1-2.el7 will be installed
---> Package libtiff.x86_64 0:4.0.3-32.el7 will be installed
--> Processing Dependency: libjbig.so.2.0()(64bit) for package: libtiff-4.0.3-32.el7.x86_64
---> Package libxcb.x86_64 0:1.13-1.el7 will be installed
--> Processing Dependency: libXau.so.6()(64bit) for package: libxcb-1.13-1.el7.x86_64
---> Package libxslt.x86_64 0:1.1.28-5.el7 will be installed
---> Package lksctp-tools.x86_64 0:1.0.17-2.el7 will be installed
---> Package pango.x86_64 0:1.42.4-4.el7_7 will be installed
--> Processing Dependency: libthai(x86-64) >= 0.1.9 for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libXft(x86-64) >= 2.0.0 for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: harfbuzz(x86-64) >= 1.4.2 for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: fribidi(x86-64) >= 1.0 for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libthai.so.0(LIBTHAI_0.1)(64bit) for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libthai.so.0()(64bit) for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libharfbuzz.so.0()(64bit) for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libfribidi.so.0()(64bit) for package: pango-1.42.4-4.el7_7.x86_64
--> Processing Dependency: libXft.so.2()(64bit) for package: pango-1.42.4-4.el7_7.x86_64
---> Package pcsc-lite-libs.x86_64 0:1.8.8-8.el7 will be installed
---> Package python-javapackages.noarch 0:3.4.1-11.el7 will be installed
--> Processing Dependency: python-lxml for package: python-javapackages-3.4.1-11.el7.noarch
---> Package ttmkfdir.x86_64 0:3.0.9-42.el7 will be installed
---> Package tzdata-java.noarch 0:2020a-1.el7 will be installed
---> Package xalan-j2.noarch 0:2.7.1-23.el7 will be installed
--> Processing Dependency: xerces-j2 for package: xalan-j2-2.7.1-23.el7.noarch
--> Processing Dependency: osgi(org.apache.xerces) for package: xalan-j2-2.7.1-23.el7.noarch
---> Package xorg-x11-font-utils.x86_64 1:7.5-21.el7 will be installed
--> Processing Dependency: libfontenc.so.1()(64bit) for package: 1:xorg-x11-font-utils-7.5-21.el7.x86_64
--> Running transaction check
---> Package avahi-libs.x86_64 0:0.6.31-20.el7 will be installed
---> Package dejavu-fonts-common.noarch 0:2.33-6.el7 will be installed
---> Package fribidi.x86_64 0:1.0.2-1.el7_7.1 will be installed
---> Package harfbuzz.x86_64 0:1.7.5-2.el7 will be installed
--> Processing Dependency: libgraphite2.so.3()(64bit) for package: harfbuzz-1.7.5-2.el7.x86_64
---> Package jasper-libs.x86_64 0:1.900.1-33.el7 will be installed
---> Package jbigkit-libs.x86_64 0:2.0-11.el7 will be installed
---> Package libXau.x86_64 0:1.0.8-2.1.el7 will be installed
---> Package libXft.x86_64 0:2.3.2-2.el7 will be installed
---> Package libfontenc.x86_64 0:1.1.3-3.el7 will be installed
---> Package libglvnd-egl.x86_64 1:1.0.1-0.8.git5baa1e5.el7 will be installed
--> Processing Dependency: libglvnd(x86-64) = 1:1.0.1-0.8.git5baa1e5.el7 for package: 1:libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64
--> Processing Dependency: mesa-libEGL(x86-64) >= 13.0.4-1 for package: 1:libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64
--> Processing Dependency: libGLdispatch.so.0()(64bit) for package: 1:libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64
---> Package libglvnd-glx.x86_64 1:1.0.1-0.8.git5baa1e5.el7 will be installed
--> Processing Dependency: mesa-libGL(x86-64) >= 13.0.4-1 for package: 1:libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.x86_64
---> Package libthai.x86_64 0:0.1.14-9.el7 will be installed
---> Package pixman.x86_64 0:0.34.0-1.el7 will be installed
---> Package python-lxml.x86_64 0:3.2.1-4.el7 will be installed
---> Package xerces-j2.noarch 0:2.11.0-17.el7_0 will be installed
--> Processing Dependency: xml-commons-resolver >= 1.2 for package: xerces-j2-2.11.0-17.el7_0.noarch
--> Processing Dependency: xml-commons-apis >= 1.4.01 for package: xerces-j2-2.11.0-17.el7_0.noarch
--> Processing Dependency: osgi(org.apache.xml.resolver) for package: xerces-j2-2.11.0-17.el7_0.noarch
--> Processing Dependency: osgi(javax.xml) for package: xerces-j2-2.11.0-17.el7_0.noarch
--> Running transaction check
---> Package graphite2.x86_64 0:1.3.10-1.el7_3 will be installed
---> Package libglvnd.x86_64 1:1.0.1-0.8.git5baa1e5.el7 will be installed
---> Package mesa-libEGL.x86_64 0:18.3.4-7.el7_8.1 will be installed
--> Processing Dependency: mesa-libgbm = 18.3.4-7.el7_8.1 for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libxshmfence.so.1()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libwayland-server.so.0()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libwayland-client.so.0()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libglapi.so.0()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libgbm.so.1()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
--> Processing Dependency: libdrm.so.2()(64bit) for package: mesa-libEGL-18.3.4-7.el7_8.1.x86_64
---> Package mesa-libGL.x86_64 0:18.3.4-7.el7_8.1 will be installed
--> Processing Dependency: libXxf86vm.so.1()(64bit) for package: mesa-libGL-18.3.4-7.el7_8.1.x86_64
---> Package xml-commons-apis.noarch 0:1.4.01-16.el7 will be installed
---> Package xml-commons-resolver.noarch 0:1.2-15.el7 will be installed
--> Running transaction check
---> Package libXxf86vm.x86_64 0:1.1.4-1.el7 will be installed
---> Package libdrm.x86_64 0:2.4.97-2.el7 will be installed
--> Processing Dependency: libpciaccess.so.0()(64bit) for package: libdrm-2.4.97-2.el7.x86_64
---> Package libwayland-client.x86_64 0:1.15.0-1.el7 will be installed
---> Package libwayland-server.x86_64 0:1.15.0-1.el7 will be installed
---> Package libxshmfence.x86_64 0:1.2-1.el7 will be installed
---> Package mesa-libgbm.x86_64 0:18.3.4-7.el7_8.1 will be installed
---> Package mesa-libglapi.x86_64 0:18.3.4-7.el7_8.1 will be installed
--> Running transaction check
---> Package libpciaccess.x86_64 0:0.14-1.el7 will be installed
--> Processing Dependency: hwdata for package: libpciaccess-0.14-1.el7.x86_64
--> Running transaction check
---> Package hwdata.x86_64 0:0.252-9.5.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

===========================================================================================================
 Package                            Arch          Version                             Repository      Size
===========================================================================================================
Installing:
 tomcat                             noarch        7.0.76-12.el7_8                     updates         92 k
Installing for dependencies:
 alsa-lib                           x86_64        1.1.8-1.el7                         base           425 k
 apache-commons-collections         noarch        3.2.1-22.el7_2                      base           509 k
 apache-commons-daemon              x86_64        1.0.13-7.el7                        base            54 k
 apache-commons-dbcp                noarch        1.4-17.el7                          base           167 k
 apache-commons-logging             noarch        1.1.2-7.el7                         base            78 k
 apache-commons-pool                noarch        1.6-9.el7                           base           113 k
 atk                                x86_64        2.28.1-2.el7                        base           263 k
 avahi-libs                         x86_64        0.6.31-20.el7                       base            62 k
 avalon-framework                   noarch        4.3-10.el7                          base            88 k
 avalon-logkit                      noarch        2.1-14.el7                          base            87 k
 cairo                              x86_64        1.15.12-4.el7                       base           741 k
 copy-jdk-configs                   noarch        3.3-10.el7_5                        base            21 k
 cups-libs                          x86_64        1:1.6.3-43.el7                      base           358 k
 dejavu-fonts-common                noarch        2.33-6.el7                          base            64 k
 dejavu-sans-fonts                  noarch        2.33-6.el7                          base           1.4 M
 ecj                                x86_64        1:4.5.2-3.el7                       base           1.9 M
 fontconfig                         x86_64        2.13.0-4.3.el7                      base           254 k
 fontpackages-filesystem            noarch        1.44-8.el7                          base           9.9 k
 freetype                           x86_64        2.8-14.el7                          base           380 k
 fribidi                            x86_64        1.0.2-1.el7_7.1                     base            79 k
 gdk-pixbuf2                        x86_64        2.36.12-3.el7                       base           570 k
 geronimo-jms                       noarch        1.1.1-19.el7                        base            31 k
 geronimo-jta                       noarch        1.1.1-17.el7                        base            20 k
 giflib                             x86_64        4.1.6-9.el7                         base            40 k
 graphite2                          x86_64        1.3.10-1.el7_3                      base           115 k
 gtk-update-icon-cache              x86_64        3.22.30-5.el7                       base            27 k
 gtk2                               x86_64        2.24.31-1.el7                       base           3.4 M
 harfbuzz                           x86_64        1.7.5-2.el7                         base           267 k
 hicolor-icon-theme                 noarch        0.12-7.el7                          base            42 k
 hwdata                             x86_64        0.252-9.5.el7                       base           2.4 M
 jasper-libs                        x86_64        1.900.1-33.el7                      base           150 k
 java-1.8.0-openjdk                 x86_64        1:1.8.0.262.b10-0.el7_8             updates        299 k
 java-1.8.0-openjdk-headless        x86_64        1:1.8.0.262.b10-0.el7_8             updates         33 M
 javamail                           noarch        1.4.6-8.el7                         base           758 k
 javapackages-tools                 noarch        3.4.1-11.el7                        base            73 k
 jbigkit-libs                       x86_64        2.0-11.el7                          base            46 k
 libICE                             x86_64        1.0.9-9.el7                         base            66 k
 libSM                              x86_64        1.2.2-2.el7                         base            39 k
 libX11                             x86_64        1.6.7-2.el7                         base           607 k
 libX11-common                      noarch        1.6.7-2.el7                         base           164 k
 libXau                             x86_64        1.0.8-2.1.el7                       base            29 k
 libXcomposite                      x86_64        0.4.4-4.1.el7                       base            22 k
 libXcursor                         x86_64        1.1.15-1.el7                        base            30 k
 libXdamage                         x86_64        1.1.4-4.1.el7                       base            20 k
 libXext                            x86_64        1.3.3-3.el7                         base            39 k
 libXfixes                          x86_64        5.0.3-1.el7                         base            18 k
 libXft                             x86_64        2.3.2-2.el7                         base            58 k
 libXi                              x86_64        1.7.9-1.el7                         base            40 k
 libXinerama                        x86_64        1.1.3-2.1.el7                       base            14 k
 libXrandr                          x86_64        1.5.1-2.el7                         base            27 k
 libXrender                         x86_64        0.9.10-1.el7                        base            26 k
 libXtst                            x86_64        1.2.3-1.el7                         base            20 k
 libXxf86vm                         x86_64        1.1.4-1.el7                         base            18 k
 libdrm                             x86_64        2.4.97-2.el7                        base           151 k
 libfontenc                         x86_64        1.1.3-3.el7                         base            31 k
 libglvnd                           x86_64        1:1.0.1-0.8.git5baa1e5.el7          base            89 k
 libglvnd-egl                       x86_64        1:1.0.1-0.8.git5baa1e5.el7          base            44 k
 libglvnd-glx                       x86_64        1:1.0.1-0.8.git5baa1e5.el7          base           125 k
 libjpeg-turbo                      x86_64        1.2.90-8.el7                        base           135 k
 libpciaccess                       x86_64        0.14-1.el7                          base            26 k
 libpng                             x86_64        2:1.5.13-7.el7_2                    base           213 k
 libthai                            x86_64        0.1.14-9.el7                        base           187 k
 libtiff                            x86_64        4.0.3-32.el7                        base           171 k
 libwayland-client                  x86_64        1.15.0-1.el7                        base            33 k
 libwayland-server                  x86_64        1.15.0-1.el7                        base            39 k
 libxcb                             x86_64        1.13-1.el7                          base           214 k
 libxshmfence                       x86_64        1.2-1.el7                           base           7.2 k
 libxslt                            x86_64        1.1.28-5.el7                        base           242 k
 lksctp-tools                       x86_64        1.0.17-2.el7                        base            88 k
 log4j                              noarch        1.2.17-16.el7_4                     base           444 k
 mesa-libEGL                        x86_64        18.3.4-7.el7_8.1                    updates        109 k
 mesa-libGL                         x86_64        18.3.4-7.el7_8.1                    updates        165 k
 mesa-libgbm                        x86_64        18.3.4-7.el7_8.1                    updates         39 k
 mesa-libglapi                      x86_64        18.3.4-7.el7_8.1                    updates         46 k
 pango                              x86_64        1.42.4-4.el7_7                      base           280 k
 pcsc-lite-libs                     x86_64        1.8.8-8.el7                         base            34 k
 pixman                             x86_64        0.34.0-1.el7                        base           248 k
 python-javapackages                noarch        3.4.1-11.el7                        base            31 k
 python-lxml                        x86_64        3.2.1-4.el7                         base           758 k
 tomcat-el-2.2-api                  noarch        7.0.76-12.el7_8                     updates         82 k
 tomcat-jsp-2.2-api                 noarch        7.0.76-12.el7_8                     updates         95 k
 tomcat-lib                         noarch        7.0.76-12.el7_8                     updates        3.9 M
 tomcat-servlet-3.0-api             noarch        7.0.76-12.el7_8                     updates        213 k
 ttmkfdir                           x86_64        3.0.9-42.el7                        base            48 k
 tzdata-java                        noarch        2020a-1.el7                         updates        188 k
 xalan-j2                           noarch        2.7.1-23.el7                        base           1.9 M
 xerces-j2                          noarch        2.11.0-17.el7_0                     base           1.1 M
 xml-commons-apis                   noarch        1.4.01-16.el7                       base           227 k
 xml-commons-resolver               noarch        1.2-15.el7                          base           108 k
 xorg-x11-font-utils                x86_64        1:7.5-21.el7                        base           104 k
 xorg-x11-fonts-Type1               noarch        7.5-9.el7                           base           521 k

Transaction Summary
===========================================================================================================
Install  1 Package (+91 Dependent packages)

Total download size: 61 M
Installed size: 183 M
Downloading packages:
(1/92): apache-commons-collections-3.2.1-22.el7_2.noarch.rpm                        | 509 kB  00:00:00
(2/92): alsa-lib-1.1.8-1.el7.x86_64.rpm                                             | 425 kB  00:00:00
(3/92): apache-commons-daemon-1.0.13-7.el7.x86_64.rpm                               |  54 kB  00:00:00
(4/92): apache-commons-dbcp-1.4-17.el7.noarch.rpm                                   | 167 kB  00:00:00
(5/92): apache-commons-logging-1.1.2-7.el7.noarch.rpm                               |  78 kB  00:00:00
(6/92): apache-commons-pool-1.6-9.el7.noarch.rpm                                    | 113 kB  00:00:00
(7/92): avahi-libs-0.6.31-20.el7.x86_64.rpm                                         |  62 kB  00:00:00
(8/92): avalon-framework-4.3-10.el7.noarch.rpm                                      |  88 kB  00:00:00
(9/92): atk-2.28.1-2.el7.x86_64.rpm                                                 | 263 kB  00:00:00
(10/92): avalon-logkit-2.1-14.el7.noarch.rpm                                        |  87 kB  00:00:00
(11/92): copy-jdk-configs-3.3-10.el7_5.noarch.rpm                                   |  21 kB  00:00:00
(12/92): cairo-1.15.12-4.el7.x86_64.rpm                                             | 741 kB  00:00:00
(13/92): cups-libs-1.6.3-43.el7.x86_64.rpm                                          | 358 kB  00:00:00
(14/92): dejavu-fonts-common-2.33-6.el7.noarch.rpm                                  |  64 kB  00:00:00
(15/92): dejavu-sans-fonts-2.33-6.el7.noarch.rpm                                    | 1.4 MB  00:00:00
(16/92): ecj-4.5.2-3.el7.x86_64.rpm                                                 | 1.9 MB  00:00:00
(17/92): fontconfig-2.13.0-4.3.el7.x86_64.rpm                                       | 254 kB  00:00:00
(18/92): freetype-2.8-14.el7.x86_64.rpm                                             | 380 kB  00:00:00
(19/92): fribidi-1.0.2-1.el7_7.1.x86_64.rpm                                         |  79 kB  00:00:00
(20/92): fontpackages-filesystem-1.44-8.el7.noarch.rpm                              | 9.9 kB  00:00:00
(21/92): gdk-pixbuf2-2.36.12-3.el7.x86_64.rpm                                       | 570 kB  00:00:00
(22/92): geronimo-jms-1.1.1-19.el7.noarch.rpm                                       |  31 kB  00:00:00
(23/92): geronimo-jta-1.1.1-17.el7.noarch.rpm                                       |  20 kB  00:00:00
(24/92): graphite2-1.3.10-1.el7_3.x86_64.rpm                                        | 115 kB  00:00:00
(25/92): giflib-4.1.6-9.el7.x86_64.rpm                                              |  40 kB  00:00:00
(26/92): gtk-update-icon-cache-3.22.30-5.el7.x86_64.rpm                             |  27 kB  00:00:00
(27/92): harfbuzz-1.7.5-2.el7.x86_64.rpm                                            | 267 kB  00:00:00
(28/92): hicolor-icon-theme-0.12-7.el7.noarch.rpm                                   |  42 kB  00:00:00
(29/92): hwdata-0.252-9.5.el7.x86_64.rpm                                            | 2.4 MB  00:00:00
(30/92): jasper-libs-1.900.1-33.el7.x86_64.rpm                                      | 150 kB  00:00:00
(31/92): javamail-1.4.6-8.el7.noarch.rpm                                            | 758 kB  00:00:00
(32/92): javapackages-tools-3.4.1-11.el7.noarch.rpm                                 |  73 kB  00:00:00
(33/92): jbigkit-libs-2.0-11.el7.x86_64.rpm                                         |  46 kB  00:00:00
(34/92): java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64.rpm                        | 299 kB  00:00:00
(35/92): libICE-1.0.9-9.el7.x86_64.rpm                                              |  66 kB  00:00:00
(36/92): libSM-1.2.2-2.el7.x86_64.rpm                                               |  39 kB  00:00:00
(37/92): gtk2-2.24.31-1.el7.x86_64.rpm                                              | 3.4 MB  00:00:00
(38/92): libX11-1.6.7-2.el7.x86_64.rpm                                              | 607 kB  00:00:00
(39/92): libXau-1.0.8-2.1.el7.x86_64.rpm                                            |  29 kB  00:00:00
(40/92): libXcomposite-0.4.4-4.1.el7.x86_64.rpm                                     |  22 kB  00:00:00
(41/92): libXcursor-1.1.15-1.el7.x86_64.rpm                                         |  30 kB  00:00:00
(42/92): libXdamage-1.1.4-4.1.el7.x86_64.rpm                                        |  20 kB  00:00:00
(43/92): libXext-1.3.3-3.el7.x86_64.rpm                                             |  39 kB  00:00:00
(44/92): libXfixes-5.0.3-1.el7.x86_64.rpm                                           |  18 kB  00:00:00
(45/92): libXft-2.3.2-2.el7.x86_64.rpm                                              |  58 kB  00:00:00
(46/92): libX11-common-1.6.7-2.el7.noarch.rpm                                       | 164 kB  00:00:00
(47/92): libXi-1.7.9-1.el7.x86_64.rpm                                               |  40 kB  00:00:00
(48/92): libXinerama-1.1.3-2.1.el7.x86_64.rpm                                       |  14 kB  00:00:00
(49/92): libXrandr-1.5.1-2.el7.x86_64.rpm                                           |  27 kB  00:00:00
(50/92): libXrender-0.9.10-1.el7.x86_64.rpm                                         |  26 kB  00:00:00
(51/92): libXxf86vm-1.1.4-1.el7.x86_64.rpm                                          |  18 kB  00:00:00
(52/92): libXtst-1.2.3-1.el7.x86_64.rpm                                             |  20 kB  00:00:00
(53/92): libdrm-2.4.97-2.el7.x86_64.rpm                                             | 151 kB  00:00:00
(54/92): libglvnd-1.0.1-0.8.git5baa1e5.el7.x86_64.rpm                               |  89 kB  00:00:00
(55/92): libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64.rpm                           |  44 kB  00:00:00
(56/92): java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64.rpm               |  33 MB  00:00:00
(57/92): libfontenc-1.1.3-3.el7.x86_64.rpm                                          |  31 kB  00:00:00
(58/92): libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.x86_64.rpm                           | 125 kB  00:00:00
(59/92): libjpeg-turbo-1.2.90-8.el7.x86_64.rpm                                      | 135 kB  00:00:00
(60/92): libpng-1.5.13-7.el7_2.x86_64.rpm                                           | 213 kB  00:00:00
(61/92): libthai-0.1.14-9.el7.x86_64.rpm                                            | 187 kB  00:00:00
(62/92): libtiff-4.0.3-32.el7.x86_64.rpm                                            | 171 kB  00:00:00
(63/92): libwayland-client-1.15.0-1.el7.x86_64.rpm                                  |  33 kB  00:00:00
(64/92): libwayland-server-1.15.0-1.el7.x86_64.rpm                                  |  39 kB  00:00:00
(65/92): libpciaccess-0.14-1.el7.x86_64.rpm                                         |  26 kB  00:00:00
(66/92): libxshmfence-1.2-1.el7.x86_64.rpm                                          | 7.2 kB  00:00:00
(67/92): libxcb-1.13-1.el7.x86_64.rpm                                               | 214 kB  00:00:00
(68/92): lksctp-tools-1.0.17-2.el7.x86_64.rpm                                       |  88 kB  00:00:00
(69/92): mesa-libEGL-18.3.4-7.el7_8.1.x86_64.rpm                                    | 109 kB  00:00:00
(70/92): mesa-libgbm-18.3.4-7.el7_8.1.x86_64.rpm                                    |  39 kB  00:00:00
(71/92): mesa-libglapi-18.3.4-7.el7_8.1.x86_64.rpm                                  |  46 kB  00:00:00
(72/92): log4j-1.2.17-16.el7_4.noarch.rpm                                           | 444 kB  00:00:00
(73/92): pango-1.42.4-4.el7_7.x86_64.rpm                                            | 280 kB  00:00:00
(74/92): libxslt-1.1.28-5.el7.x86_64.rpm                                            | 242 kB  00:00:00
(75/92): pcsc-lite-libs-1.8.8-8.el7.x86_64.rpm                                      |  34 kB  00:00:00
(76/92): python-javapackages-3.4.1-11.el7.noarch.rpm                                |  31 kB  00:00:00
(77/92): mesa-libGL-18.3.4-7.el7_8.1.x86_64.rpm                                     | 165 kB  00:00:00
(78/92): tomcat-7.0.76-12.el7_8.noarch.rpm                                          |  92 kB  00:00:00
(79/92): tomcat-el-2.2-api-7.0.76-12.el7_8.noarch.rpm                               |  82 kB  00:00:00
(80/92): python-lxml-3.2.1-4.el7.x86_64.rpm                                         | 758 kB  00:00:00
(81/92): pixman-0.34.0-1.el7.x86_64.rpm                                             | 248 kB  00:00:00
(82/92): tomcat-lib-7.0.76-12.el7_8.noarch.rpm                                      | 3.9 MB  00:00:00
(83/92): tomcat-servlet-3.0-api-7.0.76-12.el7_8.noarch.rpm                          | 213 kB  00:00:00
(84/92): ttmkfdir-3.0.9-42.el7.x86_64.rpm                                           |  48 kB  00:00:00
(85/92): tzdata-java-2020a-1.el7.noarch.rpm                                         | 188 kB  00:00:00
(86/92): tomcat-jsp-2.2-api-7.0.76-12.el7_8.noarch.rpm                              |  95 kB  00:00:00
(87/92): xerces-j2-2.11.0-17.el7_0.noarch.rpm                                       | 1.1 MB  00:00:00
(88/92): xml-commons-apis-1.4.01-16.el7.noarch.rpm                                  | 227 kB  00:00:00
(89/92): xml-commons-resolver-1.2-15.el7.noarch.rpm                                 | 108 kB  00:00:00
(90/92): xorg-x11-font-utils-7.5-21.el7.x86_64.rpm                                  | 104 kB  00:00:00
(91/92): xorg-x11-fonts-Type1-7.5-9.el7.noarch.rpm                                  | 521 kB  00:00:00
(92/92): xalan-j2-2.7.1-23.el7.noarch.rpm                                           | 1.9 MB  00:00:00
-----------------------------------------------------------------------------------------------------------
Total                                                                       28 MB/s |  61 MB  00:00:02
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libjpeg-turbo-1.2.90-8.el7.x86_64                                                      1/92
  Installing : 2:libpng-1.5.13-7.el7_2.x86_64                                                         2/92
  Installing : freetype-2.8-14.el7.x86_64                                                             3/92
  Installing : mesa-libglapi-18.3.4-7.el7_8.1.x86_64                                                  4/92
  Installing : libxshmfence-1.2-1.el7.x86_64                                                          5/92
  Installing : libxslt-1.1.28-5.el7.x86_64                                                            6/92
  Installing : fontpackages-filesystem-1.44-8.el7.noarch                                              7/92
  Installing : libICE-1.0.9-9.el7.x86_64                                                              8/92
  Installing : libwayland-server-1.15.0-1.el7.x86_64                                                  9/92
  Installing : 1:libglvnd-1.0.1-0.8.git5baa1e5.el7.x86_64                                            10/92
  Installing : libSM-1.2.2-2.el7.x86_64                                                              11/92
  Installing : dejavu-fonts-common-2.33-6.el7.noarch                                                 12/92
  Installing : dejavu-sans-fonts-2.33-6.el7.noarch                                                   13/92
  Installing : fontconfig-2.13.0-4.3.el7.x86_64                                                      14/92
  Installing : python-lxml-3.2.1-4.el7.x86_64                                                        15/92
  Installing : python-javapackages-3.4.1-11.el7.noarch                                               16/92
  Installing : javapackages-tools-3.4.1-11.el7.noarch                                                17/92
  Installing : tomcat-servlet-3.0-api-7.0.76-12.el7_8.noarch                                         18/92
  Installing : tomcat-jsp-2.2-api-7.0.76-12.el7_8.noarch                                             19/92
  Installing : tomcat-el-2.2-api-7.0.76-12.el7_8.noarch                                              20/92
  Installing : ttmkfdir-3.0.9-42.el7.x86_64                                                          21/92
  Installing : jasper-libs-1.900.1-33.el7.x86_64                                                     22/92
  Installing : libfontenc-1.1.3-3.el7.x86_64                                                         23/92
  Installing : 1:xorg-x11-font-utils-7.5-21.el7.x86_64                                               24/92
  Installing : xorg-x11-fonts-Type1-7.5-9.el7.noarch                                                 25/92
  Installing : jbigkit-libs-2.0-11.el7.x86_64                                                        26/92
  Installing : libtiff-4.0.3-32.el7.x86_64                                                           27/92
  Installing : libX11-common-1.6.7-2.el7.noarch                                                      28/92
  Installing : libthai-0.1.14-9.el7.x86_64                                                           29/92
  Installing : alsa-lib-1.1.8-1.el7.x86_64                                                           30/92
  Installing : hwdata-0.252-9.5.el7.x86_64                                                           31/92
  Installing : libpciaccess-0.14-1.el7.x86_64                                                        32/92
  Installing : libdrm-2.4.97-2.el7.x86_64                                                            33/92
  Installing : mesa-libgbm-18.3.4-7.el7_8.1.x86_64                                                   34/92
  Installing : fribidi-1.0.2-1.el7_7.1.x86_64                                                        35/92
  Installing : copy-jdk-configs-3.3-10.el7_5.noarch                                                  36/92
  Installing : hicolor-icon-theme-0.12-7.el7.noarch                                                  37/92
  Installing : libwayland-client-1.15.0-1.el7.x86_64                                                 38/92
  Installing : tzdata-java-2020a-1.el7.noarch                                                        39/92
  Installing : avahi-libs-0.6.31-20.el7.x86_64                                                       40/92
  Installing : 1:cups-libs-1.6.3-43.el7.x86_64                                                       41/92
  Installing : atk-2.28.1-2.el7.x86_64                                                               42/92
  Installing : graphite2-1.3.10-1.el7_3.x86_64                                                       43/92
  Installing : harfbuzz-1.7.5-2.el7.x86_64                                                           44/92
  Installing : pixman-0.34.0-1.el7.x86_64                                                            45/92
  Installing : libXau-1.0.8-2.1.el7.x86_64                                                           46/92
  Installing : libxcb-1.13-1.el7.x86_64                                                              47/92
  Installing : libX11-1.6.7-2.el7.x86_64                                                             48/92
  Installing : libXext-1.3.3-3.el7.x86_64                                                            49/92
  Installing : libXrender-0.9.10-1.el7.x86_64                                                        50/92
  Installing : libXfixes-5.0.3-1.el7.x86_64                                                          51/92
  Installing : libXi-1.7.9-1.el7.x86_64                                                              52/92
  Installing : libXdamage-1.1.4-4.1.el7.x86_64                                                       53/92
  Installing : libXcomposite-0.4.4-4.1.el7.x86_64                                                    54/92
  Installing : gdk-pixbuf2-2.36.12-3.el7.x86_64                                                      55/92
  Installing : gtk-update-icon-cache-3.22.30-5.el7.x86_64                                            56/92
  Installing : libXtst-1.2.3-1.el7.x86_64                                                            57/92
  Installing : libXcursor-1.1.15-1.el7.x86_64                                                        58/92
  Installing : libXrandr-1.5.1-2.el7.x86_64                                                          59/92
  Installing : libXft-2.3.2-2.el7.x86_64                                                             60/92
  Installing : libXinerama-1.1.3-2.1.el7.x86_64                                                      61/92
  Installing : libXxf86vm-1.1.4-1.el7.x86_64                                                         62/92
  Installing : 1:libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.x86_64                                        63/92
  Installing : mesa-libGL-18.3.4-7.el7_8.1.x86_64                                                    64/92
  Installing : giflib-4.1.6-9.el7.x86_64                                                             65/92
  Installing : mesa-libEGL-18.3.4-7.el7_8.1.x86_64                                                   66/92
  Installing : 1:libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64                                        67/92
  Installing : cairo-1.15.12-4.el7.x86_64                                                            68/92
  Installing : pango-1.42.4-4.el7_7.x86_64                                                           69/92
  Installing : gtk2-2.24.31-1.el7.x86_64                                                             70/92
  Installing : pcsc-lite-libs-1.8.8-8.el7.x86_64                                                     71/92
  Installing : lksctp-tools-1.0.17-2.el7.x86_64                                                      72/92
  Installing : 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64                            73/92
  Installing : 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64                                     74/92
  Installing : apache-commons-pool-1.6-9.el7.noarch                                                  75/92
  Installing : geronimo-jms-1.1.1-19.el7.noarch                                                      76/92
  Installing : apache-commons-collections-3.2.1-22.el7_2.noarch                                      77/92
  Installing : xml-commons-apis-1.4.01-16.el7.noarch                                                 78/92
  Installing : xml-commons-resolver-1.2-15.el7.noarch                                                79/92
  Installing : xalan-j2-2.7.1-23.el7.noarch                                                          80/92
  Installing : xerces-j2-2.11.0-17.el7_0.noarch                                                      81/92
  Installing : javamail-1.4.6-8.el7.noarch                                                           82/92
  Installing : log4j-1.2.17-16.el7_4.noarch                                                          83/92
  Installing : avalon-logkit-2.1-14.el7.noarch                                                       84/92
  Installing : apache-commons-logging-1.1.2-7.el7.noarch                                             85/92
  Installing : avalon-framework-4.3-10.el7.noarch                                                    86/92
  Installing : 1:ecj-4.5.2-3.el7.x86_64                                                              87/92
  Installing : geronimo-jta-1.1.1-17.el7.noarch                                                      88/92
  Installing : apache-commons-dbcp-1.4-17.el7.noarch                                                 89/92
  Installing : tomcat-lib-7.0.76-12.el7_8.noarch                                                     90/92
  Installing : apache-commons-daemon-1.0.13-7.el7.x86_64                                             91/92
  Installing : tomcat-7.0.76-12.el7_8.noarch                                                         92/92
  Verifying  : libXext-1.3.3-3.el7.x86_64                                                             1/92
  Verifying  : libXi-1.7.9-1.el7.x86_64                                                               2/92
  Verifying  : avalon-logkit-2.1-14.el7.noarch                                                        3/92
  Verifying  : libXrender-0.9.10-1.el7.x86_64                                                         4/92
  Verifying  : 1:xorg-x11-font-utils-7.5-21.el7.x86_64                                                5/92
  Verifying  : mesa-libGL-18.3.4-7.el7_8.1.x86_64                                                     6/92
  Verifying  : 1:java-1.8.0-openjdk-headless-1.8.0.262.b10-0.el7_8.x86_64                             7/92
  Verifying  : 2:libpng-1.5.13-7.el7_2.x86_64                                                         8/92
  Verifying  : freetype-2.8-14.el7.x86_64                                                             9/92
  Verifying  : gtk-update-icon-cache-3.22.30-5.el7.x86_64                                            10/92
  Verifying  : tomcat-el-2.2-api-7.0.76-12.el7_8.noarch                                              11/92
  Verifying  : python-javapackages-3.4.1-11.el7.noarch                                               12/92
  Verifying  : libXcomposite-0.4.4-4.1.el7.x86_64                                                    13/92
  Verifying  : xerces-j2-2.11.0-17.el7_0.noarch                                                      14/92
  Verifying  : lksctp-tools-1.0.17-2.el7.x86_64                                                      15/92
  Verifying  : 1:libglvnd-1.0.1-0.8.git5baa1e5.el7.x86_64                                            16/92
  Verifying  : tomcat-jsp-2.2-api-7.0.76-12.el7_8.noarch                                             17/92
  Verifying  : dejavu-sans-fonts-2.33-6.el7.noarch                                                   18/92
  Verifying  : tomcat-lib-7.0.76-12.el7_8.noarch                                                     19/92
  Verifying  : pcsc-lite-libs-1.8.8-8.el7.x86_64                                                     20/92
  Verifying  : libwayland-server-1.15.0-1.el7.x86_64                                                 21/92
  Verifying  : apache-commons-logging-1.1.2-7.el7.noarch                                             22/92
  Verifying  : libXau-1.0.8-2.1.el7.x86_64                                                           23/92
  Verifying  : apache-commons-pool-1.6-9.el7.noarch                                                  24/92
  Verifying  : python-lxml-3.2.1-4.el7.x86_64                                                        25/92
  Verifying  : libpciaccess-0.14-1.el7.x86_64                                                        26/92
  Verifying  : libICE-1.0.9-9.el7.x86_64                                                             27/92
  Verifying  : giflib-4.1.6-9.el7.x86_64                                                             28/92
  Verifying  : 1:cups-libs-1.6.3-43.el7.x86_64                                                       29/92
  Verifying  : javamail-1.4.6-8.el7.noarch                                                           30/92
  Verifying  : 1:ecj-4.5.2-3.el7.x86_64                                                              31/92
  Verifying  : libXtst-1.2.3-1.el7.x86_64                                                            32/92
  Verifying  : geronimo-jms-1.1.1-19.el7.noarch                                                      33/92
  Verifying  : tomcat-servlet-3.0-api-7.0.76-12.el7_8.noarch                                         34/92
  Verifying  : pixman-0.34.0-1.el7.x86_64                                                            35/92
  Verifying  : javapackages-tools-3.4.1-11.el7.noarch                                                36/92
  Verifying  : 1:libglvnd-egl-1.0.1-0.8.git5baa1e5.el7.x86_64                                        37/92
  Verifying  : jasper-libs-1.900.1-33.el7.x86_64                                                     38/92
  Verifying  : graphite2-1.3.10-1.el7_3.x86_64                                                       39/92
  Verifying  : libXfixes-5.0.3-1.el7.x86_64                                                          40/92
  Verifying  : atk-2.28.1-2.el7.x86_64                                                               41/92
  Verifying  : avahi-libs-0.6.31-20.el7.x86_64                                                       42/92
  Verifying  : fontconfig-2.13.0-4.3.el7.x86_64                                                      43/92
  Verifying  : gdk-pixbuf2-2.36.12-3.el7.x86_64                                                      44/92
  Verifying  : 1:libglvnd-glx-1.0.1-0.8.git5baa1e5.el7.x86_64                                        45/92
  Verifying  : libXcursor-1.1.15-1.el7.x86_64                                                        46/92
  Verifying  : tzdata-java-2020a-1.el7.noarch                                                        47/92
  Verifying  : libwayland-client-1.15.0-1.el7.x86_64                                                 48/92
  Verifying  : fontpackages-filesystem-1.44-8.el7.noarch                                             49/92
  Verifying  : ttmkfdir-3.0.9-42.el7.x86_64                                                          50/92
  Verifying  : hicolor-icon-theme-0.12-7.el7.noarch                                                  51/92
  Verifying  : log4j-1.2.17-16.el7_4.noarch                                                          52/92
  Verifying  : copy-jdk-configs-3.3-10.el7_5.noarch                                                  53/92
  Verifying  : pango-1.42.4-4.el7_7.x86_64                                                           54/92
  Verifying  : fribidi-1.0.2-1.el7_7.1.x86_64                                                        55/92
  Verifying  : libdrm-2.4.97-2.el7.x86_64                                                            56/92
  Verifying  : libjpeg-turbo-1.2.90-8.el7.x86_64                                                     57/92
  Verifying  : hwdata-0.252-9.5.el7.x86_64                                                           58/92
  Verifying  : harfbuzz-1.7.5-2.el7.x86_64                                                           59/92
  Verifying  : libxslt-1.1.28-5.el7.x86_64                                                           60/92
  Verifying  : apache-commons-dbcp-1.4-17.el7.noarch                                                 61/92
  Verifying  : libXrandr-1.5.1-2.el7.x86_64                                                          62/92
  Verifying  : xalan-j2-2.7.1-23.el7.noarch                                                          63/92
  Verifying  : apache-commons-collections-3.2.1-22.el7_2.noarch                                      64/92
  Verifying  : libxshmfence-1.2-1.el7.x86_64                                                         65/92
  Verifying  : libtiff-4.0.3-32.el7.x86_64                                                           66/92
  Verifying  : libSM-1.2.2-2.el7.x86_64                                                              67/92
  Verifying  : libXdamage-1.1.4-4.1.el7.x86_64                                                       68/92
  Verifying  : mesa-libgbm-18.3.4-7.el7_8.1.x86_64                                                   69/92
  Verifying  : libXinerama-1.1.3-2.1.el7.x86_64                                                      70/92
  Verifying  : libXxf86vm-1.1.4-1.el7.x86_64                                                         71/92
  Verifying  : mesa-libEGL-18.3.4-7.el7_8.1.x86_64                                                   72/92
  Verifying  : gtk2-2.24.31-1.el7.x86_64                                                             73/92
  Verifying  : xml-commons-apis-1.4.01-16.el7.noarch                                                 74/92
  Verifying  : alsa-lib-1.1.8-1.el7.x86_64                                                           75/92
  Verifying  : avalon-framework-4.3-10.el7.noarch                                                    76/92
  Verifying  : dejavu-fonts-common-2.33-6.el7.noarch                                                 77/92
  Verifying  : libthai-0.1.14-9.el7.x86_64                                                           78/92
  Verifying  : libX11-1.6.7-2.el7.x86_64                                                             79/92
  Verifying  : libX11-common-1.6.7-2.el7.noarch                                                      80/92
  Verifying  : libxcb-1.13-1.el7.x86_64                                                              81/92
  Verifying  : libXft-2.3.2-2.el7.x86_64                                                             82/92
  Verifying  : 1:java-1.8.0-openjdk-1.8.0.262.b10-0.el7_8.x86_64                                     83/92
  Verifying  : xml-commons-resolver-1.2-15.el7.noarch                                                84/92
  Verifying  : mesa-libglapi-18.3.4-7.el7_8.1.x86_64                                                 85/92
  Verifying  : xorg-x11-fonts-Type1-7.5-9.el7.noarch                                                 86/92
  Verifying  : geronimo-jta-1.1.1-17.el7.noarch                                                      87/92
  Verifying  : jbigkit-libs-2.0-11.el7.x86_64                                                        88/92
  Verifying  : cairo-1.15.12-4.el7.x86_64                                                            89/92
  Verifying  : tomcat-7.0.76-12.el7_8.noarch                                                         90/92
  Verifying  : apache-commons-daemon-1.0.13-7.el7.x86_64                                             91/92
  Verifying  : libfontenc-1.1.3-3.el7.x86_64                                                         92/92

Installed:
  tomcat.noarch 0:7.0.76-12.el7_8

Dependency Installed:
  alsa-lib.x86_64 0:1.1.8-1.el7
  apache-commons-collections.noarch 0:3.2.1-22.el7_2
  apache-commons-daemon.x86_64 0:1.0.13-7.el7
  apache-commons-dbcp.noarch 0:1.4-17.el7
  apache-commons-logging.noarch 0:1.1.2-7.el7
  apache-commons-pool.noarch 0:1.6-9.el7
  atk.x86_64 0:2.28.1-2.el7
  avahi-libs.x86_64 0:0.6.31-20.el7
  avalon-framework.noarch 0:4.3-10.el7
  avalon-logkit.noarch 0:2.1-14.el7
  cairo.x86_64 0:1.15.12-4.el7
  copy-jdk-configs.noarch 0:3.3-10.el7_5
  cups-libs.x86_64 1:1.6.3-43.el7
  dejavu-fonts-common.noarch 0:2.33-6.el7
  dejavu-sans-fonts.noarch 0:2.33-6.el7
  ecj.x86_64 1:4.5.2-3.el7
  fontconfig.x86_64 0:2.13.0-4.3.el7
  fontpackages-filesystem.noarch 0:1.44-8.el7
  freetype.x86_64 0:2.8-14.el7
  fribidi.x86_64 0:1.0.2-1.el7_7.1
  gdk-pixbuf2.x86_64 0:2.36.12-3.el7
  geronimo-jms.noarch 0:1.1.1-19.el7
  geronimo-jta.noarch 0:1.1.1-17.el7
  giflib.x86_64 0:4.1.6-9.el7
  graphite2.x86_64 0:1.3.10-1.el7_3
  gtk-update-icon-cache.x86_64 0:3.22.30-5.el7
  gtk2.x86_64 0:2.24.31-1.el7
  harfbuzz.x86_64 0:1.7.5-2.el7
  hicolor-icon-theme.noarch 0:0.12-7.el7
  hwdata.x86_64 0:0.252-9.5.el7
  jasper-libs.x86_64 0:1.900.1-33.el7
  java-1.8.0-openjdk.x86_64 1:1.8.0.262.b10-0.el7_8
  java-1.8.0-openjdk-headless.x86_64 1:1.8.0.262.b10-0.el7_8
  javamail.noarch 0:1.4.6-8.el7
  javapackages-tools.noarch 0:3.4.1-11.el7
  jbigkit-libs.x86_64 0:2.0-11.el7
  libICE.x86_64 0:1.0.9-9.el7
  libSM.x86_64 0:1.2.2-2.el7
  libX11.x86_64 0:1.6.7-2.el7
  libX11-common.noarch 0:1.6.7-2.el7
  libXau.x86_64 0:1.0.8-2.1.el7
  libXcomposite.x86_64 0:0.4.4-4.1.el7
  libXcursor.x86_64 0:1.1.15-1.el7
  libXdamage.x86_64 0:1.1.4-4.1.el7
  libXext.x86_64 0:1.3.3-3.el7
  libXfixes.x86_64 0:5.0.3-1.el7
  libXft.x86_64 0:2.3.2-2.el7
  libXi.x86_64 0:1.7.9-1.el7
  libXinerama.x86_64 0:1.1.3-2.1.el7
  libXrandr.x86_64 0:1.5.1-2.el7
  libXrender.x86_64 0:0.9.10-1.el7
  libXtst.x86_64 0:1.2.3-1.el7
  libXxf86vm.x86_64 0:1.1.4-1.el7
  libdrm.x86_64 0:2.4.97-2.el7
  libfontenc.x86_64 0:1.1.3-3.el7
  libglvnd.x86_64 1:1.0.1-0.8.git5baa1e5.el7
  libglvnd-egl.x86_64 1:1.0.1-0.8.git5baa1e5.el7
  libglvnd-glx.x86_64 1:1.0.1-0.8.git5baa1e5.el7
  libjpeg-turbo.x86_64 0:1.2.90-8.el7
  libpciaccess.x86_64 0:0.14-1.el7
  libpng.x86_64 2:1.5.13-7.el7_2
  libthai.x86_64 0:0.1.14-9.el7
  libtiff.x86_64 0:4.0.3-32.el7
  libwayland-client.x86_64 0:1.15.0-1.el7
  libwayland-server.x86_64 0:1.15.0-1.el7
  libxcb.x86_64 0:1.13-1.el7
  libxshmfence.x86_64 0:1.2-1.el7
  libxslt.x86_64 0:1.1.28-5.el7
  lksctp-tools.x86_64 0:1.0.17-2.el7
  log4j.noarch 0:1.2.17-16.el7_4
  mesa-libEGL.x86_64 0:18.3.4-7.el7_8.1
  mesa-libGL.x86_64 0:18.3.4-7.el7_8.1
  mesa-libgbm.x86_64 0:18.3.4-7.el7_8.1
  mesa-libglapi.x86_64 0:18.3.4-7.el7_8.1
  pango.x86_64 0:1.42.4-4.el7_7
  pcsc-lite-libs.x86_64 0:1.8.8-8.el7
  pixman.x86_64 0:0.34.0-1.el7
  python-javapackages.noarch 0:3.4.1-11.el7
  python-lxml.x86_64 0:3.2.1-4.el7
  tomcat-el-2.2-api.noarch 0:7.0.76-12.el7_8
  tomcat-jsp-2.2-api.noarch 0:7.0.76-12.el7_8
  tomcat-lib.noarch 0:7.0.76-12.el7_8
  tomcat-servlet-3.0-api.noarch 0:7.0.76-12.el7_8
  ttmkfdir.x86_64 0:3.0.9-42.el7
  tzdata-java.noarch 0:2020a-1.el7
  xalan-j2.noarch 0:2.7.1-23.el7
  xerces-j2.noarch 0:2.11.0-17.el7_0
  xml-commons-apis.noarch 0:1.4.01-16.el7
  xml-commons-resolver.noarch 0:1.2-15.el7
  xorg-x11-font-utils.x86_64 1:7.5-21.el7
  xorg-x11-fonts-Type1.noarch 0:7.5-9.el7

Complete!
[root@stapp01 ~]#
[root@stapp01 ~]# cat /usr/share/tomcat/conf/server.xml | grep connector
    <!--The connectors can use a shared executor, you can define one or more named thread pools-->
         This connector uses the BIO implementation that requires the JSSE
[root@stapp01 ~]#
[root@stapp01 ~]# vi /usr/share/tomcat/conf/server.xml
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable tomcat
Created symlink from /etc/systemd/system/multi-user.target.wants/tomcat.service to /usr/lib/systemd/system/tomcat.service.
[root@stapp01 ~]# systemctl start tomcat
[root@stapp01 ~]# systemctl status tomcat
● tomcat.service - Apache Tomcat Web Application Container
   Loaded: loaded (/usr/lib/systemd/system/tomcat.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-09-12 09:48:10 UTC; 1s ago
 Main PID: 354 (java)
   CGroup: /docker/24f4160485fa525c31b0378f2de9bb2681269a7e751d81fc672b371db418bbb4/system.slice/tomcat.service
           └─354 /usr/lib/jvm/jre/bin/java -classpath /usr/share/tomcat/bin/bootstrap.jar:/usr/share/tomcat/bin/tomcat-juli.jar:/usr/share/java/commons-daemon.jar -Dcatalin...

Sep 12 09:48:11 stapp01 server[354]: Sep 12, 2020 9:48:11 AM org.apache.catalina.core.StandardService startInternal
Sep 12 09:48:11 stapp01 server[354]: INFO: Starting service Catalina
Sep 12 09:48:11 stapp01 server[354]: Sep 12, 2020 9:48:11 AM org.apache.catalina.core.StandardEngine startInternal
Sep 12 09:48:11 stapp01 server[354]: INFO: Starting Servlet Engine: Apache Tomcat/7.0.76
Sep 12 09:48:11 stapp01 server[354]: Sep 12, 2020 9:48:11 AM org.apache.coyote.AbstractProtocol start
Sep 12 09:48:11 stapp01 server[354]: INFO: Starting ProtocolHandler ["http-bio-8081"]
Sep 12 09:48:11 stapp01 server[354]: Sep 12, 2020 9:48:11 AM org.apache.coyote.AbstractProtocol start
Sep 12 09:48:11 stapp01 server[354]: INFO: Starting ProtocolHandler ["ajp-bio-8009"]
Sep 12 09:48:11 stapp01 server[354]: Sep 12, 2020 9:48:11 AM org.apache.catalina.startup.Catalina start
Sep 12 09:48:11 stapp01 server[354]: INFO: Server startup in 51 ms
[root@stapp01 ~]#
[root@stapp01 ~]# ll /tmp
total 20
drwxr-xr-x  2 root   root   4096 Sep 12 09:46 hsperfdata_root
drwxr-xr-x  2 tomcat tomcat 4096 Sep 12 09:48 hsperfdata_tomcat
-rwx------ 36 root   root    836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 tony   tony   4529 Sep 12 09:48 ROOT.war
-rw------- 36 root   root      0 Aug  1  2019 yum.log
[root@stapp01 ~]#
[root@stapp01 ~]# ll /usr/share/tomcat/webapps/
total 0
[root@stapp01 ~]#
[root@stapp01 ~]# cp /tmp/ROOT.war /usr/share/tomcat/webapps
[root@stapp01 ~]#
[root@stapp01 ~]# ll /usr/share/tomcat/webapps/
total 8
-rw-r--r-- 1 root root 4529 Sep 12 09:49 ROOT.war
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# curl -i http://localhost:8081
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Accept-Ranges: bytes
ETag: W/"471-1580289830000"
Last-Modified: Wed, 29 Jan 2020 09:23:50 GMT
Content-Type: text/html
Content-Length: 471
Date: Sat, 12 Sep 2020 09:49:32 GMT

<!DOCTYPE html>