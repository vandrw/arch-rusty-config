#!/bin/bash

archinstall --config arch_config.json

mnt_folder="/mnt/archinstall"

# Check if mnt_folder exists
if [ ! -d "$mnt_folder" ]; then
    echo "Error: $mnt_folder does not exist"
    exit 1
fi

# Find all users on the system
for user in $(ls $mnt_flder/home); do
    if [ "$user" != "lost+found" ]; then
        users+=($user)
    fi
done

# If there is more than one user, ask which user to install for
if [ ${#users[@]} -gt 1 ]; then
    echo "Multiple users found on system. Please select a user to install for:"
    select user in "${users[@]}"; do
        if [[ " ${users[@]} " =~ " ${user} " ]]; then
            break
        else
            echo "Invalid selection"
        fi
    done
else
    user=${users[0]}
    if [ -z "$user" ]; then
        user=${users[1]}
    fi
fi

if [ -z "$user" ]; then
    echo "Error: No user found. Please verify that /mnt/archinstall/home contains a user folder."
    exit 1
fi

echo "Moving configs to home of $user. Press enter to continue..."
read -r

# Copy files to user's home directory
cp -rv .config $mnt_folder/home/$user
cp -rv .local $mnt_folder/home/$user

chmod +x post_reboot.sh
cp -av post_reboot.sh $mnt_folder/home/$user

# Greetd config is stored in /etc/greetd. We move it now to bypass using sudo later.
cp -v .config/greetd/config.toml $mnt_folder/etc/greetd/config.toml

echo "Done. Press enter to reboot..."
read -r

# arch-chroot $mnt_folder /bin/bash -c "cd /home/$user && ./post_reboot.sh"
# Reboot into the new system
reboot