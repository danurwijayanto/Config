<?php
        $oldpwd = getcwd();
        chdir('{{Folder}}');

        $log = "\n####### ".date('Y-m-d H:i:s'). " #######\n";
        $log .=  shell_exec("git pull https://{{user}}:{{password}}@bitbucket.org...customers.git master 2>&1");

        chdir($oldpwd);

        file_put_contents ('webhooks.customer-log.txt',$log,FILE_APPEND);
        echo $log;
