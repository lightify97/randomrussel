 #name: RobbyRussel

 #You can override some default options in your config.fish:
   set -g theme_display_git_untracked no

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set untracked ''
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked ^/dev/null)
end

 function fish_prompt
   set -l last_status $status
   set -l cyan (set_color -o 0F92B4)
   set -l yellow (set_color -o yellow)
   set -l red (set_color -o red)
   set -l blue (set_color -o 1B63B1)
   set -l green (set_color -o 00ff88)
   set -l magenta (set_color  -o  magenta)
   set -l normal (set_color   normal)
   set -l normal (set_color -o normal)
   set -l white (set_color -o white)
   

   set -l cwd (basename (prompt_pwd))
 
   if [ (_git_branch_name) ]
   set -l git_branch $red(_git_branch_name)
   set git_info "$blue git:($git_branch$blue)"
 
     if [ (_is_git_dirty) ]
     set -l dirty "$yellow✗"
       set git_info "$git_info$dirty"
   else
     set -l clean "$green"
     set git_info "$git_info$clean"
     end
  end
 set -l exit_code $status
 set -l rand_colors F44336 E91E63 9C27B0 673AB7 3F51B5 2196F3 03A9F4 00BCD4 009688 4CAF50 8BC34A CDDC39 FFEB3B FFC107 FF9800 FF5722 EF9A9A  81D4FA D32F2F C2185B 7B1FA2 512DA8 303F9F 1976D2 0288D1 0097A7 00796B 388E3C 689F38 AFB42B FBC02D FFA000 F57C00 E64A19 5D4037 616161 455A64
 set -l rand_color_idx (math (random) \% 36 + 1)

set_color -o $rand_colors[$rand_color_idx]

echo -n -s '  '$cwd '' $git_info ' '

if test $last_status = 0
    set_color -o $rand_colors[$rand_color_idx]
    printf ''
  #  printf ' '
   # printf ' '
else
    set_color -o fa1111
    printf '✗'
end
set_color normal
printf ' '
end

