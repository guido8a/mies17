/**
 * Created by IntelliJ IDEA.
 * User: luz
 * Date: 6/23/11
 * Time: 11:57 AM
 * To change this template use File | Settings | File Templates.
 */
function number_format(number, decimals, dec_point, thousands_sep) {
    // Formats a number with grouped thousands
    //
    // version: 1103.1210
    // discuss at: http://phpjs.org/functions/number_format    // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +     bugfix by: Michael White (http://getsprink.com)
    // +     bugfix by: Benjamin Lupton
    // +     bugfix by: Allan Jensen (http://www.winternet.no)    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
    // +     bugfix by: Howard Yeend
    // +    revised by: Luke Smith (http://lucassmith.name)
    // +     bugfix by: Diogo Resende
    // +     bugfix by: Rival    // +      input by: Kheang Hok Chin (http://www.distantia.ca/)
    // +   improved by: davook
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +      input by: Jay Klehr
    // +   improved by: Brett Zamir (http://brett-zamir.me)    // +      input by: Amir Habibi (http://www.residence-mixte.com/)
    // +     bugfix by: Brett Zamir (http://brett-zamir.me)
    // +   improved by: Theriault
    // +      input by: Amirouche
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)    // *     example 1: number_format(1234.56);
    // *     returns 1: '1,235'
    // *     example 2: number_format(1234.56, 2, ',', ' ');
    // *     returns 2: '1 234,56'
    // *     example 3: number_format(1234.5678, 2, '.', '');    // *     returns 3: '1234.57'
    // *     example 4: number_format(67, 2, ',', '.');
    // *     returns 4: '67,00'
    // *     example 5: number_format(1000);
    // *     returns 5: '1,000'    // *     example 6: number_format(67.311, 2);
    // *     returns 6: '67.31'
    // *     example 7: number_format(1000.55, 1);
    // *     returns 7: '1,000.6'
    // *     example 8: number_format(67000, 5, ',', '.');    // *     returns 8: '67.000,00000'
    // *     example 9: number_format(0.9, 0);
    // *     returns 9: '1'
    // *    example 10: number_format('1.20', 2);
    // *    returns 10: '1.20'    // *    example 11: number_format('1.20', 4);
    // *    returns 11: '1.2000'
    // *    example 12: number_format('1.2000', 3);
    // *    returns 12: '1.200'
    // *    example 13: number_format('1 000,50', 2, '.', ' ');    // *    returns 13: '100 050.00'
    // Strip all characters but numerical ones.
    number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
    var n = !isFinite(+number) ? 0 : +number,
        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
        sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
        dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
        s = '',
        toFixedFix = function (n, prec) {
            var k = Math.pow(10, prec);
            return '' + Math.round(n * k) / k;
        };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}


function trim(str, charlist) {
    // Strips whitespace from the beginning and end of a string
    //
    // version: 1103.1210
    // discuss at: http://phpjs.org/functions/trim    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: mdsjack (http://www.mdsjack.bo.it)
    // +   improved by: Alexander Ermolaev (http://snippets.dzone.com/user/AlexanderErmolaev)
    // +      input by: Erkekjetter
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)    // +      input by: DxGx
    // +   improved by: Steven Levithan (http://blog.stevenlevithan.com)
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman
    // *     example 1: trim('    Kevin van Zonneveld    ');    // *     returns 1: 'Kevin van Zonneveld'
    // *     example 2: trim('Hello World', 'Hdle');
    // *     returns 2: 'o Wor'
    // *     example 3: trim(16, 1);
    // *     returns 3: 6    var whitespace, l = 0,
    i = 0;
    str += '';

    if (!charlist) {        // default list
        whitespace = " \n\r\t\f\x0b\xa0\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u200b\u2028\u2029\u3000";
    } else {
        // preg_quote custom list
        charlist += '';
        whitespace = charlist.replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^\:])/g, '$1');
    }

    l = str.length;
    for (i = 0; i < l; i++) {
        if (whitespace.indexOf(str.charAt(i)) === -1) {
            str = str.substring(i);
            break;
        }
    }
    l = str.length;
    for (i = l - 1; i >= 0; i--) {
        if (whitespace.indexOf(str.charAt(i)) === -1) {
            str = str.substring(0, i + 1);
            break;
        }
    }

    return whitespace.indexOf(str.charAt(0)) === -1 ? str : '';
}

function substr(str, start, len) {
    // Returns part of a string
    //
    // version: 909.322
    // discuss at: http://phpjs.org/functions/substr    // +     original by: Martijn Wieringa
    // +     bugfixed by: T.Wild
    // +      tweaked by: Onno Marsman
    // +      revised by: Theriault
    // +      improved by: Brett Zamir (http://brett-zamir.me)    // %    note 1: Handles rare Unicode characters if 'unicode.semantics' ini (PHP6) is set to 'on'
    // *       example 1: substr('abcdef', 0, -1);
    // *       returns 1: 'abcde'
    // *       example 2: substr(2, 0, -6);
    // *       returns 2: false    // *       example 3: ini_set('unicode.semantics',  'on');
    // *       example 3: substr('a\uD801\uDC00', 0, -1);
    // *       returns 3: 'a'
    // *       example 4: ini_set('unicode.semantics',  'on');
    // *       example 4: substr('a\uD801\uDC00', 0, 2);    // *       returns 4: 'a\uD801\uDC00'
    // *       example 5: ini_set('unicode.semantics',  'on');
    // *       example 5: substr('a\uD801\uDC00', -1, 1);
    // *       returns 5: '\uD801\uDC00'
    // *       example 6: ini_set('unicode.semantics',  'on');    // *       example 6: substr('a\uD801\uDC00z\uD801\uDC00', -3, 2);
    // *       returns 6: '\uD801\uDC00z'
    // *       example 7: ini_set('unicode.semantics',  'on');
    // *       example 7: substr('a\uD801\uDC00z\uD801\uDC00', -3, -1)
    // *       returns 7: '\uD801\uDC00z'    // Add: (?) Use unicode.runtime_encoding (e.g., with string wrapped in "binary" or "Binary" class) to
    // allow access of binary (see file_get_contents()) by: charCodeAt(x) & 0xFF (see https://developer.mozilla.org/En/Using_XMLHttpRequest ) or require conversion first?
    var i = 0,
        allBMP = true,
        es = 0, el = 0,
        se = 0,
        ret = '';
    str += '';
    var end = str.length;
    // BEGIN REDUNDANT
    this.php_js = this.php_js || {};
    this.php_js.ini = this.php_js.ini || {};
    // END REDUNDANT
    switch ((this.php_js.ini['unicode.semantics'] && this.php_js.ini['unicode.semantics'].local_value.toLowerCase())) {
        case 'on':
            // Full-blown Unicode including non-Basic-Multilingual-Plane characters
            // strlen()
            for (i = 0; i < str.length; i++) {
                if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1))) {
                    allBMP = false;
                    break;
                }
            }
            if (!allBMP) {
                if (start < 0) {
                    for (i = end - 1, es = (start += end); i >= es; i--) {
                        if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1))) {
                            start--;
                            es--;
                        }
                    }
                } else {
                    var surrogatePairs = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g;
                    while ((surrogatePairs.exec(str)) != null) {
                        var li = surrogatePairs.lastIndex;
                        if (li - 2 < start) {
                            start++;
                        } else {
                            break;
                        }
                    }
                }
                if (start >= end || start < 0) {
                    return false;
                }
                if (len < 0) {
                    for (i = end - 1, el = (end += len); i >= el; i--) {
                        if (/[\uDC00-\uDFFF]/.test(str.charAt(i)) && /[\uD800-\uDBFF]/.test(str.charAt(i - 1))) {
                            end--;
                            el--;
                        }
                    }
                    if (start > end) {
                        return false;
                    }
                    return str.slice(start, end);
                } else {
                    se = start + len;
                    for (i = start; i < se; i++) {
                        ret += str.charAt(i);
                        if (/[\uD800-\uDBFF]/.test(str.charAt(i)) && /[\uDC00-\uDFFF]/.test(str.charAt(i + 1))) {
                            se++; // Go one further, since one of the "characters" is part of a surrogate pair
                        }
                    }
                    return ret;
                }
                break;
            }
        // Fall-through
        case 'off':
        // assumes there are no non-BMP characters;        //    if there may be such characters, then it is best to turn it on (critical in true XHTML/XML)
        default:
            if (start < 0) {
                start += end;
            }
            end = typeof len === 'undefined' ? end : (len < 0 ? len + end : len + start);
        // PHP returns false if start does not fall within the string.
        // PHP returns false if the calculated end comes before the calculated start.
        // PHP returns an empty string if start and end are the same.
        // Otherwise, PHP returns the portion of the string from start to end.        return start >= str.length || start < 0 || start > end ? !1 : str.slice(start, end);
    }
    return undefined; // Please Netbeans
}

function str_replace(search, replace, subject, count) {
    // Replaces all occurrences of search in haystack with replace
    //
    // version: 1103.1210
    // discuss at: http://phpjs.org/functions/str_replace    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Gabriel Paderni
    // +   improved by: Philip Peterson
    // +   improved by: Simon Willison (http://simonwillison.net)
    // +    revised by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)    // +   bugfixed by: Anton Ongson
    // +      input by: Onno Marsman
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    tweaked by: Onno Marsman
    // +      input by: Brett Zamir (http://brett-zamir.me)    // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   input by: Oleg Eremeev
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +   bugfixed by: Oleg Eremeev
    // %          note 1: The count parameter must be passed as a string in order    // %          note 1:  to find a global variable in which the result will be given
    // *     example 1: str_replace(' ', '.', 'Kevin van Zonneveld');
    // *     returns 1: 'Kevin.van.Zonneveld'
    // *     example 2: str_replace(['{name}', 'l'], ['hello', 'm'], '{name}, lars');
    // *     returns 2: 'hemmo, mars'
    var i = 0,
        j = 0,
        temp = '',
        repl = '',
        sl = 0, fl = 0,
        f = [].concat(search),
        r = [].concat(replace),
        s = subject,
        ra = r instanceof Array, sa = s instanceof Array;
    s = [].concat(s);
    if (count) {
        this.window[count] = 0;
    }
    for (i = 0, sl = s.length; i < sl; i++) {
        if (s[i] === '') {
            continue;
        }
        for (j = 0, fl = f.length; j < fl; j++) {
            temp = s[i] + '';
            repl = ra ? (r[j] !== undefined ? r[j] : '') : r[0];
            s[i] = (temp).split(f[j]).join(repl);
            if (count && s[i] !== temp) {
                this.window[count] += (temp.length - s[i].length) / f[j].length;
            }
        }
    }
    return sa ? s : s[0];
}

function str_pad(input, pad_length, pad_string, pad_type) {
    // Returns input string padded on the left or right to specified length with pad_string
    //
    // version: 1103.1210
    // discuss at: http://phpjs.org/functions/str_pad    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // + namespaced by: Michael White (http://getsprink.com)
    // +      input by: Marco van Oort
    // +   bugfixed by: Brett Zamir (http://brett-zamir.me)
    // *     example 1: str_pad('Kevin van Zonneveld', 30, '-=', 'STR_PAD_LEFT');    // *     returns 1: '-=-=-=-=-=-Kevin van Zonneveld'
    // *     example 2: str_pad('Kevin van Zonneveld', 30, '-', 'STR_PAD_BOTH');
    // *     returns 2: '------Kevin van Zonneveld-----'
    var half = '',
        pad_to_go;
    var str_pad_repeater = function (s, len) {
        var collect = '',
            i;
        while (collect.length < len) {
            collect += s;
        }
        collect = collect.substr(0, len);
        return collect;
    };

    input += '';
    pad_string = pad_string !== undefined ? pad_string : ' ';
    if (pad_type != 'STR_PAD_LEFT' && pad_type != 'STR_PAD_RIGHT' && pad_type != 'STR_PAD_BOTH') {
        pad_type = 'STR_PAD_RIGHT';
    }
    if ((pad_to_go = pad_length - input.length) > 0) {
        if (pad_type == 'STR_PAD_LEFT') {
            input = str_pad_repeater(pad_string, pad_to_go) + input;
        } else if (pad_type == 'STR_PAD_RIGHT') {
            input = input + str_pad_repeater(pad_string, pad_to_go);
        } else if (pad_type == 'STR_PAD_BOTH') {
            half = str_pad_repeater(pad_string, Math.ceil(pad_to_go / 2));
            input = half + input + half;
            input = input.substr(0, pad_length);
        }
    }
    return input;
}

function utf8_encode(argString) {
    // Encodes an ISO-8859-1 string to UTF-8
    //
    // version: 1109.2015
    // discuss at: http://phpjs.org/functions/utf8_encode    // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: sowberry
    // +    tweaked by: Jack
    // +   bugfixed by: Onno Marsman    // +   improved by: Yves Sucaet
    // +   bugfixed by: Onno Marsman
    // +   bugfixed by: Ulrich
    // +   bugfixed by: Rafal Kukawski
    // *     example 1: utf8_encode('Kevin van Zonneveld');    // *     returns 1: 'Kevin van Zonneveld'
    if (argString === null || typeof argString === "undefined") {
        return "";
    }
    var string = (argString + ''); // .replace(/\r\n/g, "\n").replace(/\r/g, "\n");
    var utftext = "",
        start, end, stringl = 0;

    start = end = 0;
    stringl = string.length;
    for (var n = 0; n < stringl; n++) {
        var c1 = string.charCodeAt(n);
        var enc = null;
        if (c1 < 128) {
            end++;
        } else if (c1 > 127 && c1 < 2048) {
            enc = String.fromCharCode((c1 >> 6) | 192) + String.fromCharCode((c1 & 63) | 128);
        } else {
            enc = String.fromCharCode((c1 >> 12) | 224) + String.fromCharCode(((c1 >> 6) & 63) | 128) + String.fromCharCode((c1 & 63) | 128);
        }
        if (enc !== null) {
            if (end > start) {
                utftext += string.slice(start, end);
            }
            utftext += enc;
            start = end = n + 1;
        }
    }
    if (end > start) {
        utftext += string.slice(start, stringl);
    }
    return utftext;
}

function md5(str) {
    // Calculate the md5 hash of a string
    //
    // version: 1109.2015
    // discuss at: http://phpjs.org/functions/md5    // +   original by: Webtoolkit.info (http://www.webtoolkit.info/)
    // + namespaced by: Michael White (http://getsprink.com)
    // +    tweaked by: Jack
    // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +      input by: Brett Zamir (http://brett-zamir.me)    // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // -    depends on: utf8_encode
    // *     example 1: md5('Kevin van Zonneveld');
    // *     returns 1: '6e658d4bfcb59cc13f96c14450ac40b9'
    var xl;
    var rotateLeft = function (lValue, iShiftBits) {
        return (lValue << iShiftBits) | (lValue >>> (32 - iShiftBits));
    };
    var addUnsigned = function (lX, lY) {
        var lX4, lY4, lX8, lY8, lResult;
        lX8 = (lX & 0x80000000);
        lY8 = (lY & 0x80000000);
        lX4 = (lX & 0x40000000);
        lY4 = (lY & 0x40000000);
        lResult = (lX & 0x3FFFFFFF) + (lY & 0x3FFFFFFF);
        if (lX4 & lY4) {
            return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
        }
        if (lX4 | lY4) {
            if (lResult & 0x40000000) {
                return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
            } else {
                return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
            }
        } else {
            return (lResult ^ lX8 ^ lY8);
        }
    };
    var _F = function (x, y, z) {
        return (x & y) | ((~x) & z);
    };
    var _G = function (x, y, z) {
        return (x & z) | (y & (~z));
    };
    var _H = function (x, y, z) {
        return (x ^ y ^ z);
    };
    var _I = function (x, y, z) {
        return (y ^ (x | (~z)));
    };

    var _FF = function (a, b, c, d, x, s, ac) {
        a = addUnsigned(a, addUnsigned(addUnsigned(_F(b, c, d), x), ac));
        return addUnsigned(rotateLeft(a, s), b);
    };

    var _GG = function (a, b, c, d, x, s, ac) {
        a = addUnsigned(a, addUnsigned(addUnsigned(_G(b, c, d), x), ac));
        return addUnsigned(rotateLeft(a, s), b);
    };

    var _HH = function (a, b, c, d, x, s, ac) {
        a = addUnsigned(a, addUnsigned(addUnsigned(_H(b, c, d), x), ac));
        return addUnsigned(rotateLeft(a, s), b);
    };

    var _II = function (a, b, c, d, x, s, ac) {
        a = addUnsigned(a, addUnsigned(addUnsigned(_I(b, c, d), x), ac));
        return addUnsigned(rotateLeft(a, s), b);
    };

    var convertToWordArray = function (str) {
        var lWordCount;
        var lMessageLength = str.length;
        var lNumberOfWords_temp1 = lMessageLength + 8;
        var lNumberOfWords_temp2 = (lNumberOfWords_temp1 - (lNumberOfWords_temp1 % 64)) / 64;
        var lNumberOfWords = (lNumberOfWords_temp2 + 1) * 16;
        var lWordArray = new Array(lNumberOfWords - 1);
        var lBytePosition = 0;
        var lByteCount = 0;
        while (lByteCount < lMessageLength) {
            lWordCount = (lByteCount - (lByteCount % 4)) / 4;
            lBytePosition = (lByteCount % 4) * 8;
            lWordArray[lWordCount] = (lWordArray[lWordCount] | (str.charCodeAt(lByteCount) << lBytePosition));
            lByteCount++;
        }
        lWordCount = (lByteCount - (lByteCount % 4)) / 4;
        lBytePosition = (lByteCount % 4) * 8;
        lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80 << lBytePosition);
        lWordArray[lNumberOfWords - 2] = lMessageLength << 3;
        lWordArray[lNumberOfWords - 1] = lMessageLength >>> 29;
        return lWordArray;
    };

    var wordToHex = function (lValue) {
        var wordToHexValue = "",
            wordToHexValue_temp = "", lByte, lCount;
        for (lCount = 0; lCount <= 3; lCount++) {
            lByte = (lValue >>> (lCount * 8)) & 255;
            wordToHexValue_temp = "0" + lByte.toString(16);
            wordToHexValue = wordToHexValue + wordToHexValue_temp.substr(wordToHexValue_temp.length - 2, 2);
        }
        return wordToHexValue;
    };

    var x = [], k, AA, BB, CC, DD, a, b, c, d, S11 = 7,
        S12 = 12,
        S13 = 17,
        S14 = 22,
        S21 = 5, S22 = 9,
        S23 = 14,
        S24 = 20,
        S31 = 4,
        S32 = 11, S33 = 16,
        S34 = 23,
        S41 = 6,
        S42 = 10,
        S43 = 15, S44 = 21;

    str = this.utf8_encode(str);
    x = convertToWordArray(str);
    a = 0x67452301;
    b = 0xEFCDAB89;
    c = 0x98BADCFE;
    d = 0x10325476;

    xl = x.length;
    for (k = 0; k < xl; k += 16) {
        AA = a;
        BB = b;
        CC = c;
        DD = d;
        a = _FF(a, b, c, d, x[k + 0], S11, 0xD76AA478);
        d = _FF(d, a, b, c, x[k + 1], S12, 0xE8C7B756);
        c = _FF(c, d, a, b, x[k + 2], S13, 0x242070DB);
        b = _FF(b, c, d, a, x[k + 3], S14, 0xC1BDCEEE);
        a = _FF(a, b, c, d, x[k + 4], S11, 0xF57C0FAF);
        d = _FF(d, a, b, c, x[k + 5], S12, 0x4787C62A);
        c = _FF(c, d, a, b, x[k + 6], S13, 0xA8304613);
        b = _FF(b, c, d, a, x[k + 7], S14, 0xFD469501);
        a = _FF(a, b, c, d, x[k + 8], S11, 0x698098D8);
        d = _FF(d, a, b, c, x[k + 9], S12, 0x8B44F7AF);
        c = _FF(c, d, a, b, x[k + 10], S13, 0xFFFF5BB1);
        b = _FF(b, c, d, a, x[k + 11], S14, 0x895CD7BE);
        a = _FF(a, b, c, d, x[k + 12], S11, 0x6B901122);
        d = _FF(d, a, b, c, x[k + 13], S12, 0xFD987193);
        c = _FF(c, d, a, b, x[k + 14], S13, 0xA679438E);
        b = _FF(b, c, d, a, x[k + 15], S14, 0x49B40821);
        a = _GG(a, b, c, d, x[k + 1], S21, 0xF61E2562);
        d = _GG(d, a, b, c, x[k + 6], S22, 0xC040B340);
        c = _GG(c, d, a, b, x[k + 11], S23, 0x265E5A51);
        b = _GG(b, c, d, a, x[k + 0], S24, 0xE9B6C7AA);
        a = _GG(a, b, c, d, x[k + 5], S21, 0xD62F105D);
        d = _GG(d, a, b, c, x[k + 10], S22, 0x2441453);
        c = _GG(c, d, a, b, x[k + 15], S23, 0xD8A1E681);
        b = _GG(b, c, d, a, x[k + 4], S24, 0xE7D3FBC8);
        a = _GG(a, b, c, d, x[k + 9], S21, 0x21E1CDE6);
        d = _GG(d, a, b, c, x[k + 14], S22, 0xC33707D6);
        c = _GG(c, d, a, b, x[k + 3], S23, 0xF4D50D87);
        b = _GG(b, c, d, a, x[k + 8], S24, 0x455A14ED);
        a = _GG(a, b, c, d, x[k + 13], S21, 0xA9E3E905);
        d = _GG(d, a, b, c, x[k + 2], S22, 0xFCEFA3F8);
        c = _GG(c, d, a, b, x[k + 7], S23, 0x676F02D9);
        b = _GG(b, c, d, a, x[k + 12], S24, 0x8D2A4C8A);
        a = _HH(a, b, c, d, x[k + 5], S31, 0xFFFA3942);
        d = _HH(d, a, b, c, x[k + 8], S32, 0x8771F681);
        c = _HH(c, d, a, b, x[k + 11], S33, 0x6D9D6122);
        b = _HH(b, c, d, a, x[k + 14], S34, 0xFDE5380C);
        a = _HH(a, b, c, d, x[k + 1], S31, 0xA4BEEA44);
        d = _HH(d, a, b, c, x[k + 4], S32, 0x4BDECFA9);
        c = _HH(c, d, a, b, x[k + 7], S33, 0xF6BB4B60);
        b = _HH(b, c, d, a, x[k + 10], S34, 0xBEBFBC70);
        a = _HH(a, b, c, d, x[k + 13], S31, 0x289B7EC6);
        d = _HH(d, a, b, c, x[k + 0], S32, 0xEAA127FA);
        c = _HH(c, d, a, b, x[k + 3], S33, 0xD4EF3085);
        b = _HH(b, c, d, a, x[k + 6], S34, 0x4881D05);
        a = _HH(a, b, c, d, x[k + 9], S31, 0xD9D4D039);
        d = _HH(d, a, b, c, x[k + 12], S32, 0xE6DB99E5);
        c = _HH(c, d, a, b, x[k + 15], S33, 0x1FA27CF8);
        b = _HH(b, c, d, a, x[k + 2], S34, 0xC4AC5665);
        a = _II(a, b, c, d, x[k + 0], S41, 0xF4292244);
        d = _II(d, a, b, c, x[k + 7], S42, 0x432AFF97);
        c = _II(c, d, a, b, x[k + 14], S43, 0xAB9423A7);
        b = _II(b, c, d, a, x[k + 5], S44, 0xFC93A039);
        a = _II(a, b, c, d, x[k + 12], S41, 0x655B59C3);
        d = _II(d, a, b, c, x[k + 3], S42, 0x8F0CCC92);
        c = _II(c, d, a, b, x[k + 10], S43, 0xFFEFF47D);
        b = _II(b, c, d, a, x[k + 1], S44, 0x85845DD1);
        a = _II(a, b, c, d, x[k + 8], S41, 0x6FA87E4F);
        d = _II(d, a, b, c, x[k + 15], S42, 0xFE2CE6E0);
        c = _II(c, d, a, b, x[k + 6], S43, 0xA3014314);
        b = _II(b, c, d, a, x[k + 13], S44, 0x4E0811A1);
        a = _II(a, b, c, d, x[k + 4], S41, 0xF7537E82);
        d = _II(d, a, b, c, x[k + 11], S42, 0xBD3AF235);
        c = _II(c, d, a, b, x[k + 2], S43, 0x2AD7D2BB);
        b = _II(b, c, d, a, x[k + 9], S44, 0xEB86D391);
        a = addUnsigned(a, AA);
        b = addUnsigned(b, BB);
        c = addUnsigned(c, CC);
        d = addUnsigned(d, DD);
    }
    var temp = wordToHex(a) + wordToHex(b) + wordToHex(c) + wordToHex(d);

    return temp.toLowerCase();
}

/**
 * requires date.js
 */
Date.prototype.isBefore = function (date) {
    return(this.compareTo(date) === -1);
};
Date.prototype.isAfter = function (date) {
    return(this.compareTo(date) === 1);
};

Date.prototype.isAfterE = function (date) {
    return(this.compareTo(date) === 1 || this.compareTo(date) === 0);
};

Date.prototype.isBeforeE = function (date) {
    return(this.compareTo(date) === -1 || this.compareTo(date) === 0);
};

/**
 * requires JQuery
 * Example: $("div:icontains('John')").css("text-decoration", "underline");
 */
$.expr[':'].icontains = function (obj, index, meta, stack) {
    return (obj.textContent || obj.innerText || jQuery(obj).text() || '').toLowerCase().indexOf(meta[3].toLowerCase()) >= 0;
};

