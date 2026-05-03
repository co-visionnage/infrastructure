users:
  - name: ubuntu
    ssh-authorized-keys:
      - ${ssh_public_key}
    groups: sudo
    shell: /bin/bash
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    passwd: "$6$u.QGtXvp89g2Gb7V$hskf37UFVvqGrTw2y2A7iyAGK8T2EiIw1qGG7G33xWX/vi7WTQ0i/tty6uOuZSpLKq7Ufn79DbWZeP8Lwa/MD/"
    lock_passwd: false
hostname: ${vm_name}
manage_etc_hosts: true
