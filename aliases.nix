{
  hms = "home-manager switch";
  c = "clear";
  hdn = "ls -la";
  u = "cd ..";
  uu = "cd ../..";
  uuu = "cd ../../..";
  uuuu = "cd ../../../..";
  uuuuu = "cd ../../../../..";
  uuuuuu = "cd ../../../../../..";
  # Git
  gst = "git status";
  gp = "git pull";
  gpu = "git push";
  git-nevermind = "git-abort ; git reset . ; git checkout . ; git clean -f -d";
  gol = "git log --oneline";
  gsu = "git push --set-upstream origin";
  lg = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
}
