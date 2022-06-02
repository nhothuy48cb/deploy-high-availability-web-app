ssh-keygen -t rsa -b 4096 -f ~/.ssh/udagramBastionKey -C "Udagram bastion key" -N "" -q
aws ssm put-parameter --name 'udagramBastionKey' --value "$(cat ~/.ssh/udagramBastionKey.pub)" --type SecureString --overwrite

ssh-keygen -t rsa -b 4096 -f ~/.ssh/udagramWebappKey -C "Udagram webapp key" -N "" -q
aws ssm put-parameter --name 'udagramWebappKeyPrivate' --value "$(cat ~/.ssh/udagramWebappKey)" --type SecureString --overwrite
aws ssm put-parameter --name 'udagramWebappKey' --value "$(cat ~/.ssh/udagramWebappKey.pub)" --type SecureString --overwrite