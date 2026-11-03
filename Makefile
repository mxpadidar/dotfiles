.PHONY: install collect link install-v2rayn ssh-key install-openvpn

install:
	@bash ./install.sh

link:
	@python3 ./scripts/link.py

install-v2rayn:
	@bash ./scripts/v2ran-install.sh

ssh-key:
	@bash ./scripts/ssh-key.sh

install-openvpn:
	@sudo pacman -S --needed openvpn
	@bash ./ovpn/install.sh

collect:
	@python3 ./scripts/collect.py

