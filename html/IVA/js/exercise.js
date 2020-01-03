var layoutSet = {
    pageStyle: {
        width: 100, // 宽度 百分比
        height: 100, // 视口的相对大小
        backGroundColor: '#232225', // 背景颜色
        fontSize: '20px'
    }
};
var layout = {
    layoutPages: function() {
        var oPageStyle = document.querySelector('.pages');
        oPageStyle.style.width = layoutSet.pageStyle.width + "%";
        oPageStyle.style.height = layoutSet.pageStyle.height + "vh";
        oPageStyle.style.backgroundColor = layoutSet.pageStyle.backGroundColor;
        oPageStyle.style.fontSize = layoutSet.pageStyle.fontSize;
        return this;
    }
};
layout.layoutPages();



