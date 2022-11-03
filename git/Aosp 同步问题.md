# AOSP 同步问题

1. 确保git config global 配置了user.name user.email

2. /ca-certificates.crt CRLfile: none
   使用： git config  --global http.sslverify false

3. .repo/manifests/: contains uncommitted changes
    1. git stash && git clean -d -f  
    或
    2. git config core.filemode false

4. 