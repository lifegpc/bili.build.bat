var showdown = require('showdown')
var fs = require('fs')
var converter = new showdown.Converter()
converter.setOption('ghCompatibleHeaderId', true)
String.prototype.replaceall = function (s1, s2) {
    var v = this
    var v2 = v.replace(s1, s2)
    while (v != v2) {
        v = v2
        v2 = v.replace(s1, s2)
    }
    return v2
}
String.prototype.tofullHTML = function (css) {
    return "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><style>" + css + "</style></head><body>" + this + "</body></html>"
}
var f = fs.readFileSync('html.css');
var css = f.toString();
fs.readFile('README.md', function (err, data) {
    if (err) {
        return console.error(err)
    }
    var s = data.toString()
    s = s.replaceall('(#登录时发生错误使用chromedriver时)', '(#登录时发生错误（使用chromedriver时）)')
    s = s.replaceall('easyuse.md', 'easyuse.html')
    var html = converter.makeHtml(s)
    fs.writeFile('README.html', html.tofullHTML(css), () => { })
})
fs.readFile('easyuse.md', function (err, data) {
    if (err) {
        return console.error(err)
    }
    var s = data.toString()
    s = s.replaceall('../../releases', 'https://github.com/lifegpc/bili/releases')
    s = s.replaceall('README.md', 'README.html')
    var html = converter.makeHtml(s)
    fs.writeFile('easyuse.html', html.tofullHTML(css), () => { })
})
