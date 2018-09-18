var addressInit = function (_cmbProvince, _cmbCity, _cmbArea, defaultProvince, defaultCity, defaultArea, _upload,_chooseAdd) {
    var cmbProvince = document.getElementById(_cmbProvince);
    var cmbCity = document.getElementById(_cmbCity);
    var cmbArea = document.getElementById(_cmbArea);
    var upload = document.getElementById(_upload);
    var chooseadd = document.getElementById(_chooseAdd);

    function cmbSelect(cmb, str) {
        for (var i = 0; i < cmb.options.length; i++) {
            if (cmb.options[i].value == str) {
                cmb.selectedIndex = i;
                return;
            }
        }
    }

    function cmbAddOption(cmb, str, obj) {
        var option = document.createElement("OPTION");
        cmb.options.add(option);
        option.innerHTML = str;
        option.value = str;
        option.obj = obj;
    }

    function changeCity() {
        cmbArea.options.length = 0;
        if (cmbCity.selectedIndex == -1)return;
        var item = cmbCity.options[cmbCity.selectedIndex].obj;
        for (var i = 0; i < item.areaList.length; i++) {
            cmbAddOption(cmbArea, item.areaList[i], null);
        }
        cmbSelect(cmbArea, defaultArea);
    }

    function changeProvince() {
        cmbCity.options.length = 0;
        cmbCity.onchange = null;
        if (cmbProvince.selectedIndex == -1)return;
        if (cmbProvince.selectedIndex == 0) {
            cmbCity.style.display = "none";
            cmbArea.style.display = "none";
            upload.style.display = "inline-block";
            chooseadd.style.display="none";
        } else if (cmbProvince.selectedIndex == 1) {
            cmbCity.style.display = "inline-block";
            cmbArea.style.display = "none";
            upload.style.display = "none";
            chooseadd.style.display = "block";
        } else {
            cmbCity.style.display = "inline-block";
            cmbArea.style.display = "inline-block";
            upload.style.display = "none";
            chooseadd.style.display="none";
        }
        var item = cmbProvince.options[cmbProvince.selectedIndex].obj;
        for (var i = 0; i < item.cityList.length; i++) {
            cmbAddOption(cmbCity, item.cityList[i].name, item.cityList[i]);
        }
        cmbSelect(cmbCity, defaultCity);
        changeCity();
        cmbCity.onchange = changeCity;
    }

    for (var i = 0; i < provinceList.length; i++) {
        cmbAddOption(cmbProvince, provinceList[i].name, provinceList[i]);
    }
    cmbSelect(cmbProvince, defaultProvince);
    changeProvince();
    cmbProvince.onchange = changeProvince;
}

var provinceList = [
    {
        name: '批量', cityList: [
        {name: '空', areaList: []},
        {name: '空', areaList: []}
    ]
    },
    {
        name: '定向', cityList: [
        {name: '爬取深度', areaList: []},
        {name: '1', areaList: []},
        {name: '2', areaList: []},
        {name: '3', areaList: []},
        {name: '4', areaList: []},
        {name: '5', areaList: []}
    ]
    },
    {
        name: 'APP', cityList: [
        {name: 'andriod', areaList: ['华为', '中兴']},
        {name: 'ios', areaList: ['ios4.1', 'ios5.1']}
    ]
    }
];