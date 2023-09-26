HTMLElement.prototype.getClasses = function() {
  var classes = _.filter(this.className.split(' '), function(className) {
    return !!className && className != '';
  });
  return classes;
}

HTMLElement.prototype.addClass = function(newClass) {
  var classes = this.getClasses();
  if (!_.has(classes, newClass)) {
    classes.push(newClass);
  }
  this.className = classes.join(' ');
  return this;
};

HTMLElement.prototype.removeClass = function(targetClass) {
  var classes = this.getClasses();
  classes = _.filter(classes, function(existingClass) {
    return existingClass != targetClass;
  });
  this.className = classes.join(' ');
  return this;
};

window.addEventListener('load', function() {
  // 1. 사이드바, 상단 네비바의 영문 메뉴명을 한글로 변경.
  var menuTitleMap = {
    "Get Client ID": "광고단위 ID 발급받기",
    "Install SDK": "SDK 설치하기",
    "Project Setting": "프로젝트 설정",
    "Banner Ad": "배너 광고 연동",
    "Responsive Banner Ad": "반응형 배너 광고 연동",
    "Native Ad": "네이티브 광고 연동",
    "Brand Ad": "브랜드 검색 광고 연동",
    "BizBoard Ad": "비즈보드 네이티브 광고 연동",
    "BizBoard Expandable Ad": "비즈보드 익스펜더블 소재 지원",
    "BizBoard Banner Ad": "비즈보드 배너 광고 연동",
    "Internal APIs": "내부 매체용 API 사용하기",
    "OptOut": "옵트아웃 버튼 설정",
    "AdFitAdView Template": "이미지/동영상 템플릿 뷰",
    "BizBoard Ad Template": "비즈보드 템플릿 연동",
    "For OpenChat": "오픈채팅을 위한 광고 연동",
    "Add SKAdNetworkID": "SKAdNetwork Ids 추가",
    "Add Publisher Data": "타겟팅 향상을 위한 지면데이터 수집 "
  };
  var elems = document.querySelectorAll('.navigation a, .doc_title');
  elems.forEach(function(elem) {
    if (!!menuTitleMap[elem.innerHTML]) {
      elem.innerHTML = menuTitleMap[elem.innerHTML];
    }
  });

  // 2. 섹션명이 Documentation인 경우 섹션명 숨김.
  var sectionNameElem = document.querySelector('h1.section_name');
  if (!!sectionNameElem && sectionNameElem.innerHTML === 'Documentation') {
    sectionNameElem.style.display = 'none';
  }

  // 3. swift, objective-c 샘플 코드를 탭 UI로 변환.  
  var tabTitles = document.querySelectorAll('.tab-title');
  var tabItems = _.map(tabTitles, function(titleElem) {
    return {
      title: titleElem,
      code: titleElem.nextElementSibling,
    };
  });
  var tabGroups = _.groupBy(tabItems, function(item) {
    return item.title.getAttribute('data-tab-name');
  });
  
  _.each(tabGroups, function(group) {
    var firstElem = _.first(group).title;
    if (!!firstElem) {
      var tabPane = document.createElement('div').addClass('tab-pane');
      var tabBar = document.createElement('div').addClass('tab-bar');
      tabPane.appendChild(tabBar);
      firstElem.parentNode.insertBefore(tabPane, firstElem);
      _.each(group, function(item, index) {
        selectTabIndex(group, 0);
        item.title.addEventListener('click', function() {
          selectTabIndex(group, index);
        });
        tabBar.appendChild(item.title);
        tabPane.appendChild(item.code);
        selectTabIndex(0);
      });
    }
  });

  function selectTabIndex(tabGroup, targetIndex) {
    _.each(tabGroup, function(item, index) {
      if (index == targetIndex) {
        item.title.removeClass('inactive');
        item.code.style.display = 'block';
      } else {
        item.title.addClass('inactive');
        item.code.style.display = 'none';
      }
    });
  };
});