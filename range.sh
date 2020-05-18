#!/usr/bin/awk -f
BEGIN {
	OFS = "\t"
	print "min" , "--", "max", "value", "OK/NG"
}

{
	if (NF < 2) {
		print "shortage of field"
		err = 1
		next
	}
	limit = index($2, "%") ? $1 * $2 / 100 : $1 * $2
	min = $1 - limit
	max = $1 + limit
	ret = (min <= $3 && max >= $3) ? "OK" : "NG"

	if (NF >= 3) {
		print $1 - limit, "--", $1 + limit, $3, ret
	} else {
		print $1 - limit, "--", $1 + limit
	}
}

END {
	if (err) {
		print "不正な行がありました。正しいデータの並びは以下です。"
		print "第1フィールド 第2フィールド 第3フィールド（任意）"
		print "公称値 公称誤差 測定値"
	}
}
