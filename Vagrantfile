Vagrant.configure("2") do |config|
  # Máquina Web
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.provision "shell", path: "provision-web.sh"
  end

  # Máquina DB (reto)
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.11"
    db.vm.provision "shell", path: "provision-db.sh"
  end
end
