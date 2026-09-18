{
  config,
  lib,
  pkgs,
  ...
}:
let
  asciiArt = ''
                                                                                                   
                                                                                                   
                                                                                                   
                                                                                                   
                                                                                                   
                                     ++                                                            
                                     +++                                                           
                                      +++                                                          
                                      ++++                                                         
                                       +++++                                  +                    
                                       ++++++                               ++                     
                                       +++++++                            +++                      
                                        ++++++++                        ++++                       
                                        +++++++++                     ++++++                       
                                         +++++++++                  +++++++                        
                                         ++++++++++               ++++++++                         
                                          +++++++++++           +++++++++                          
                                          ++++++++++++        ++++++++++                           
                                          +++++++++++++     +++++++++++                            
                                           +++++++++++++  ++++++++++++                             
                              +++++++++++++              ++++++++++++                              
       +++++++++++++++++++++++++++++++++++                ++++++++++                               
            +++++++++++++++++++++++++++++                  ++++++++                                
                  ++++++++++++++++++++++                    +++++++                                
                        +++++++++++++++                      +++++                                 
                              ++++++++                        +++                                  
                                    +                                                              
                                   +++                         +++++++                             
                                  +++++                      +++++++++++++++                       
                                 +++++++                    ++++++++++++++++++++++                 
                                 ++++++++                  +++++++++++++++++++++++++++++           
                                ++++++++++                +++++++++++++++++++++++++++++++++++      
                               ++++++++++++              +++++++++++++                             
                              ++++++++++++  +++++++++++++                                          
                             +++++++++++     +++++++++++++                                         
                            ++++++++++        ++++++++++++                                         
                           +++++++++           ++++++++++++                                        
                          ++++++++               ++++++++++                                        
                         +++++++                  +++++++++                                        
                        ++++++                     +++++++++                                       
                        ++++                        ++++++++                                       
                       +++                            +++++++                                      
                      ++                               ++++++                                      
                     +                                  +++++                                      
                                                          ++++                                     
                                                           +++                                     
                                                            +++                                    
                                                             ++                                    
                                                                                                   
                                                                                                   
                                                                                                   
                                                                                                   
                                                                                                   
  '';
  onix-banner = pkgs.writeShellScriptBin "onix-banner" "cat /etc/onix/ascii-art.txt";
in
{
  system.nixos.distroId = "onixos";
  system.nixos.distroName = "oNixOs";
  system.nixos.tags = [ ];
  system.stateVersion = lib.mkDefault "26.05";

  environment.etc."motd".text = asciiArt;

  environment.etc."onix/ascii-art.txt".text = asciiArt;

  environment.systemPackages = [ onix-banner ];

  boot.loader.grub.splashImage = lib.mkForce ../../assets/icon.png;

  boot.plymouth = {
    enable = lib.mkDefault true;
    theme = lib.mkDefault "bgrt";
  };
}
