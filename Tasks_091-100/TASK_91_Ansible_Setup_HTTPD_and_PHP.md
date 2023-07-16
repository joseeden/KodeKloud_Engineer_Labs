
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-01-17 19:42:42  
Finished: &nbsp;&nbsp;2023-01-18 03:53:00  

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 91: Ansible Setup Httpd and PHP

## Requirements

Nautilus Application development team wants to test the Apache and PHP setup on one of the app servers in Stratos Datacenter. They want the DevOps team to prepare an Ansible playbook to accomplish this task. Below you can find more details about the task.

- There is an inventory file **~/playbooks/inventory** on jump host.

- Create a playbook **~/playbooks/httpd.yml** on jump host and perform the following tasks on **App Server 1**.

  - Install httpd and php packages (whatever default version is available in yum repo).

  - Change default document root of Apache to **/var/www/html/myroot** in default Apache config **/etc/httpd/conf/httpd.conf**. Make sure /var/www/html/myroot path exists (if not please create the same).

  - There is a template **~/playbooks/templates/phpinfo.php.j2** on jump host. Copy this template to the Apache document root you created as **phpinfo.php** file and make sure user owner and the group owner for this file is **apache** user.

  - Start and enable httpd service.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory httpd.yml, so please make sure the playbook works this way without passing any extra arguments.

------------------------------

## Steps

Proceed to the given directory.

```bash
cd ~/playbooks/
```

As good practice, confirm that the jumphost is able to reach all three App Servers by running a PING. All three should return a PONG response.

```bash
$ ansible -m ping all -i inventory 

stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```

Create the **httpd.yml** based on the requirements.

```bash

- name: Setup HTTPD and PHP on App Server 1
  hosts: stapp01
  become: yes
  tasks:

    - name: Install latest version of httpd and php
      package:
        name:
          - httpd
          - php
        state: latest

    - name: Replace default DocumentRoot in httpd.conf
      replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: DocumentRoot \"\/var\/www\/html\"
        replace: DocumentRoot "/var/www/html/myroot"

    - name: If non-existent, create the new DocumentRoot directory 
      file:
        path: /var/www/html/myroot
        state: directory
        owner: apache
        group: apache

    - name: Generate phpinfo.php
      template:
        src: /home/thor/playbooks/templates/phpinfo.php.j2
        dest: /var/www/html/myroot/phpinfo.php
        owner: apache
        group: apache

    - name: Start and enable service httpd
      service:
        name: httpd
        state: started
        enabled: yes 
```

Run the playbook.

```bash
$ ansible-playbook  -i inventory httpd.yml

PLAY [Setup HTTPD and PHP on App Server 1] **********************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [stapp01]

TASK [Install latest version of httpd and php] ******************************************************************************************************

changed: [stapp01]

TASK [Replace default DocumentRoot in httpd.conf] ***************************************************************************************************
changed: [stapp01]

TASK [If non-existent, create the new DocumentRoot directory] ***************************************************************************************
changed: [stapp01]

TASK [Generate phpinfo.php] *************************************************************************************************************************
changed: [stapp01]

TASK [Start and enable service httpd] ***************************************************************************************************************
changed: [stapp01]

PLAY RECAP ******************************************************************************************************************************************
stapp01                    : ok=6    changed=5    unreachable=0    failed=0   1skipped=0    rescued=0    ignored=0   
```


To verify, we can login to the App server to check for the package. We could just check the package from the jump host itself.

```bash
$ ansible -i inventory stapp01 -m shell -a "rpm -qa | grep -e httpd -e php"

stapp02 | CHANGED | rc=0 >1

httpd-tools-2.4.6-97.el7.centos.5.x86_64
php-cli-5.4.16-48.el7.x86_64
httpd-2.4.6-97.el7.centos.5.x86_64
php-common-5.4.16-48.el7.x8
```

Also, confirm that the httpd is running on the App Server 1.

```bash
$ ansible -i inventory stapp01 -m shell -a "sudo systemctl status httpd"

[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo
stapp02 | CHANGED | rc=0 >1
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-01-17 19:35:16 UTC; 8min ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 1422 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/f6a5c3a590304b6265a866029b25c2ac4e21613a5d154ee5407fe2ff86ad6c9c/system.slice/httpd.service
           ├─1422 /usr/sbin/httpd -DFOREGROUND
           ├─1423 /usr/sbin/httpd -DFOREGROUND
           ├─1424 /usr/sbin/httpd -DFOREGROUND
           ├─1425 /usr/sbin/httpd -DFOREGROUND
           ├─1426 /usr/sbin/httpd -DFOREGROUND
           └─1427 /usr/sbin/httpd -DFOREGROUND
```


------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/06/ansible-setup-httpd-and-php.html