# Deploy a Custom Contract in 5 Minutes

Hello, this is Mishka Shishka. Use this guide to deploy a custom smart contract on the Seismic network.

First, you need to prepare your PC:

Install Rust:  
```bash
curl https://sh.rustup.rs -sSf | sh  # choose default, just press enter
. "$HOME/.cargo/env"
```

Install jq (for macOS):  
```bash
brew install jq
```

Install sfoundryup:  
```bash
curl -L   -H "Accept: application/vnd.github.v3.raw"   "https://api.github.com/repos/SeismicSystems/seismic-foundry/contents/sfoundryup/install?ref=seismic" | bash
source ~/.bashrc
```

Run sfoundryup (takes between 5 to 60 minutes, it's normal to stall at 98%):  
```bash
sfoundryup
```

# Clone a repository with a contract:  

Official (basic contract):  
```bash
git clone --recurse-submodules https://github.com/SeismicSystems/try-devnet.git
cd try-devnet/packages/contract/
```

Custom (my custom contract):  
```bash
git clone https://github.com/YAMISHKA02/Seismic-custom-contract.git
cd Seismic-custom-contract/packages/contract/
```

Run this command from the `packages/contract/` directory:  
```bash
bash script/deploy.sh
```


# If you deployed official contract, you can interact with that:

Install Bun
```bash
curl -fsSL https://bun.sh/install | bash
```
Install node dependencies
```bash
cd ../cli/
bun install
```
Send transactions
```bash
bash script/transact.sh
```

                                                                                                            
                      :--------.        :----------------    ---------------   ---------                    
                     --:@@@@@#--:      ---@@@@@@@@@@@@@*--. --#@@@@@@@@@@@#-----*@@@@@---                   
                     -=@=-%@@@%--      --@-:#@@@@@@@@@@@%---:-:*@@@@@@@@@@@@---%*:+@@@@--.                  
                     -=@=@@@@@%--      --@-%@@@@@@@@@@@*----%+#@@@@@@@@@@@#----%*+@@@@@--.                  
                     -=@@@@@@@%--      --@@@@@@@@--------.--%@@@@@@@-------- --%@@@@@@@--.                  
                     -=@@@@@@@%--      --@@@@@@@@******=----%@@@@@@@--****+----=#@@@@@+--.                  
                     -=@@@@@@@%--      --@@@@@@@@@@@@@@@%---%@@@@@@@-@@@@@@@----*@@@@@--                    
                     -=@@@@@@@%--      --@@@@@@@@@@@@@@*----%@@@@@@@--@@@@@%----:+@@@---                    
                  +@*-=@@@@@@@%----::  --@@@@@@@@--------:--%@@@@@@@---#@@@%--@=----:--:.                   
               :@@@@%-=@@@@@@@%=====-----@@@@@@@@--       --%@@@@@@@+++%@@@%----=#@@@+--@@@#                
              @@@@@@%-=@@@@@@@@@@@@@*----@@@@@@@@--       --%@@@@@@@@@@@@@@%----*@@@@@--%@@@@:              
            =@@@@@@@%-=@@@@@@@@@@@@@@+---@@@@@@@@--       ---%@@@@@@@@@@@@#-----*@@@@@--%@@@@@@             
           =@@@@@@@@@--:@@@@@@@@@@@@+-----@@@@@%--:        ---#@@@@@@@@@@*---@+--+@@@---@@@@@@@:            
            :+@@@@@@@@----------------: :--------:          .--------------+@@@*-------@@@@@:-==            
            %@@:%@@@@@@@@@@@@@@@@#   ..                                . .%@@@@@@@@@@@@@=:@@@@@#            
             @@@@=+@@@@@@@@@=.=#@@@@@#                                 %@#:=*=.:%@@@:-@@@@@@@@@@            
             @@@@@@#.+*+-.%@@@@@@@@@%                                  -@@@@--###*:@@@@@@@@@@@@#            
             *@@@@@@@@: #@@@@@@@@@@@=                                   %@@@@@+:==@@@@@@@@@@@@@-            
             :@@@@@@@@-@@@@@@@@@@@@%                                    -@@@@@@%:@@@@@@@@@@@@@@.            
              @@@@@@@-%@@@@@@@@@@@@=                                     @@@@@@@+#@@@@@@@@@@@@@             
              +@@@@@-#@@@@@@@@@@@@@                                      *@@@@@@@.@@@@@@@@@@@@@             
               @@@@+#@@@@@@@@@@@+                                         %@@@@@@#+@@@@@@@@@%               
                  :*@@@@@@@%+                                               +@@@@@:@@@@@@%                  
                  =**++=--*=:.-                 @@@@@@@@@@@@                 +- =@-@@@@.==                  
                .@@@@@#. :@@@@@@              @@ @@@@@@@@@#.@@              #=.+##-.=**.=@#                 
                 -#@@@@-#@@@@@*              %@@=@@@@@@@@@@+@@              -@@@@@@#*.-@@@%                 
                 =.+*+--=+=+-               .@@@@@@@@+%@@@@@@@@                -@@@@@+#=..                  
                 @@@= ::-:   :              @@@%=#@@@ :@@@-:@@@*              #@#.:+*##*--@                 
                 :@@@@@=#@@@@@-+           @@@@@@@@@@@@@@@@@@@@@+           *+:@@@@@@-#@@@%                 
              .**-:. .:-=%@+ :+*-        .@@@@@###@@@@@@@@+#@@@@@@         +**+ *@@**@@#.:..*:              
              =*=++:.:=****=.:-=*       @@@@@@@@@@@@@@@@@@@@@@@@@@@:      .***-:-..:=+*--@@=**              
             .**+.@@@--@@@@@@@#=*- .+ #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:.=  =***==@@@@@*:%@@#.**-             
             -****-. -%@@@@%+:=**-%+-@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ @-.*****= :#@@+- =****+             
             =*******************:@@@#=@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.@@@%. +****************.              
              +****************= .@@@@@:++++***********+=@@@@@@%*@@@+@@@@@.-.-************- :--             
             .  =+**********- :-:=@@@@@-***************+@@@@@@@@+@@@+@@@@@:-=- -=+*+=..: .-----.            
              ---:.    .:  :---- %@@@@@-***************+@@@@@@@@@@@@+@@@@@=-- -------: .-------.            
               ------:  .------:.@@@@@@:****************@@@@@@@@@+@@*@@@@@@ :---------- .----               
               .------- :----: -@@@@@:@@-*************:@@@@@@@@@@*@@%%@@@@@@# ----------..-:                
                 ------ :-:    #@@=#@@@@@=**********=#@@@@@@@@@@@@+#@*@@@@@%-   :--------                   
                               @-@@@@@@@@@ -+*****-%@@@@@@@@@@@@@@@@@=*@@@-@@-                              
                               @@@@@@@@@#%@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@+#@@@#                              
                               =@@@@@@@=@@@@@@@@@@@@@@#@@@@*+@@@@@@@@@@=@@@@@+                              
                                %*.+@%*@@@@@@@@@@@@@@@=@@@@@@@+@@@@@@%+@@@@@@                               
                                +@@@@:@@@@@@@@@@@@@@@+@@@@@@@@@#--:..#@@@@@@+                               
                                 #@@@+@@@@@@@@@@@@@@@@@@@@@@@@@%+****+.@@@@@                                
                                  @@@#%@@@@@@@@@@@@@*@@@@@@@@@@+*******+:%@=                                
                                                                                                            
                                                                                                            
                                                                                                            
