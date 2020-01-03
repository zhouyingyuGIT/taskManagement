



/*前台调用*/

var $ = function () {
    return new Base();
}

function Base() {//创建一个对象 也是构造函数
    //创建一个数组,来保存获取的节点(ID)和节点数组(name,tagName等)
    this.elements = [];
}



/*获取元素节点*/

//获取ID节点
Base.prototype.getId = function (id) {
    /*push() 方法可向数组的末尾添加一个或多个元素,并返回新的长度。*/
    this.elements.push(document.getElementById(id));
    return this;
};

//获取tagName
Base.prototype.getTagName = function (tag) {
    //tagName是一个集合 所有要在遍历
    var tag = document.getElementsByTagName(tag);
    for (var i = 0; i < tag.length; i++) {
        this.elements.push(tag[i]);
    }
    return this;
};

//获取Name
Base.prototype.getName = function (nmae) {
    //tagName是一个集合 所有要在遍历
    var names = document.getElementsByName(nmae);
    for (var i = 0; i < names.length; i++) {
        this.elements.push(names[i]);
    }
    return this;
};

/*添加方法*/

//获取CLASS节点方法(所有的class节点,或某个区域的节点)
Base.prototype.getClass = function (className, idName) {//添加获取ID某个区域
    var node = null;//定义一个节点对象
    if (arguments.length == 2) {
        node = document.getElementById(idName);
    } else {
        node = document;
    }
    var all = node.getElementsByTagName('*');
    for (var i = 0; i < all.length; i++) {
        //判断 如果你传过来的class==class
        if (all[i].className == className) {
            //那么久返回摸传过来的所有className
            this.elements.push(all[i]);
        }
    }
    return this;
};

//获取一个元素节点(只需获取一个)
Base.prototype.getElement = function (number) {
    //获取某一个元素节点 参数为number数字
    var element = this.elements[number];//得到元素的对象
    this.elements = [];//再清空元素
    this.elements[0] = element;//得到一个元素
    return this;//返回
};

//添上(设置)CSS方法 
Base.prototype.css = function (attr, value) {//两个参数 属性和值
    for (var i = 0; i < this.elements.length; i++) {
        //获取样式行内和外链都可以获取
        if (arguments.length == 1) {
            if (typeof window.getComputedStyle != 'undefined') {//W3C标准
                return window.getComputedStyle(this.elements[i], null)[attr];
                //调用属性
            } else if (typeof this.elements[i].currentStyle != 'undefined') {//IE浏览器
                return this.elements[i].style[attr];
            }
        }
        this.elements[i].style[attr] = value;
    }
    return this
};

//添加CLASS方法
Base.prototype.addClass = function (className) {
    for (var i = 0; i < this.elements.length; i++) {//遍历
        //判断不重复添加样式 用正则表示判断添加在第一个还是最后一个
        if (!this.elements[i].className.match(new RegExp('(\\s|^)' + className + '(\\s|^)'))) {
            this.elements[i].className += ' ' + className;//添加做个cass样式
        }
    }
    return this;//返回再次调用 否则只能调用一次
};

//移除CLASS方法
Base.prototype.removeClass = function (classsName) {
    for (var i = 0; i < this.elements.length; i++) {//遍历 如果有多个
        //判断该样式是否添加重复
        if (this.elements[i].className.match(new RegExp('(\\s|^)' + classsName + '(\\s|$)'))) {
            this.elements[i].className = this.elements[i].className.replace(new RegExp('(\\s|^)' + classsName + '(\\s|$)'), '');//+=''+累加多个样式之间 用空格隔开
        }
    }
    return this;//返回实现连缀
};

//添加(设置)innerHTML方法
Base.prototype.html = function (str) {
    for (var i = 0; i < this.elements.length; i++) {
        if (arguments.length == 0) {//获取innerHTML的值
            return this.elements[i].innerHTML;
        }
        this.elements[i].innerHTML = str;
    }
    return this;
};

//触发点击事件
Base.prototype.click = function (fn) {
    for (var i = 0; i < this.elements.length; i++) {
        this.elements[i].onclick = fn;
    }
    return this;
};
