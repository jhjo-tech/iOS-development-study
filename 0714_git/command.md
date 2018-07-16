# Git 명령어

- `git remove -v`
  - 현재 저장소의 및 url을 출력합니다.
- `git remote set-url origin <변경될 깃허브 주소> `
  - 깃허브 주소를 변경합니다.

- `git push -f orgin master`
  - push 할 때 -f 옵션을 주면 강제로 기존 서버에 있던 브랜치의 내용을 덮어 씁니다.



## 상황별 사용

- 깃허브의 원격 레파지토리를 삭제하고 같은 이름으로 다시 만들어 줬습니다. 그리고 그리고 push를 하려고 하니 에러가 발생했습니다.
  - 우선 깃허브의 최신 레파지토리를  `git remote set-url origin <변경될 깃허브 주소> ` 를 사용해서 변경해주고` git push -f orgin master` 를 사용해서 브랜치를 덮어쓰기하면 해결됩니다.
