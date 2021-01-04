# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.box_version = "1.0.282"
  config.vm.box_check_update = false
   config.vm.provider "virtualbox" do |vb|
     vb.gui = false  
     vb.memory = "1024"
     vb.linked_clone = true
     vb.cpus = 2
   end
  config.vm.define "terraform" do |ter|
    ter.vm.hostname = "terraform"
    ter.vm.synced_folder "tf" , "/home/vagrant/src", :mount_options => ["dmode=755,fmode=755"]
    ter.vm.synced_folder "secrets" , "/home/vagrant/keys", :mount_options => ["dmode=755,fmode=400"]
    ter.vm.provider "virtualbox" do |tvb|
      tvb.name = "terraform_vm"
    end
  end
   config.vm.provision "shell", inline: <<-SHELL
     timedatectl set-timezone Europe/London
     timedatectl set-ntp true
     timedatectl --adjust-system-clock
     apt-get update
     apt-get install -y unzip
     cd /vagrant/software
     unzip *.zip
     mv terraform /usr/bin
     chmod a+x /usr/bin/terraform
     terraform version
   SHELL
end
