# tf-openvpn
This project is intended to help people wanting to setup an OpenVPN instance in AWs.

## Dependencies

Please follow dependencies links to install them.
 
- make
- [terraform](https://www.terraform.io/downloads.html)
- [AWS CLI with credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- ssh-keygen

## Install & Run 

Run that command :

```bash
sh ./magic.sh
```

### Re-deploy

````bash
make deploy
````

### Re-install

````bash
make install
````

### Uninstall

Run this command :

````bash
make uninstall
````
