# Configure GPG Key for Signing Git Commits

To configure a signing key for GitHub, you can follow these steps:

1. **Generate a new GPG key**:
   ```bash
   gpg --full-generate-key
   ```

2. **Follow the prompts to generate the key**:
   - Select the kind of key you want (RSA or RSA and RSA).
   - Choose the key size (4096 bits is recommended for security).
   - Set the key validity (0 = key does not expire).
   - Enter your name and email address.

3. **List your GPG keys**:
   ```bash
   gpg --list-secret-keys --keyid-format LONG
   ```

4. **Locate the GPG key ID**:
   Look for the key ID in the output, it will be something like `sec   4096R/<KEY_ID> YYYY-MM-DD [expires: YYYY-MM-DD]`.

5. **Export the GPG key**:
   ```bash
   gpg --armor --export {{KEY_ID}}
   ```

6. **Copy the GPG key**:
   Copy the GPG key, starting with `-----BEGIN PGP PUBLIC KEY BLOCK-----` and ending with `-----END PGP PUBLIC KEY BLOCK-----`.

7. **Add the GPG key to your GitHub account**:
   - Go to GitHub > Settings > SSH and GPG keys.
   - Click on "New GPG key" and paste the GPG key.
   - Save the key.

8. **Configure Git to use the GPG key for signing**:
   ```bash
   git config --global user.signingkey {{KEY_ID}}
   git config --global commit.gpgsign true
   ```

Now, your Git commits will be signed with the GPG key you configured.