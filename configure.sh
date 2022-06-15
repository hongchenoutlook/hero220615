#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�9�bconfigure.sh �R]o�0}ϯ�dU���mb ����M�Ԫ��eR���8v�vݯ�NR�b/Ql�s��ܓ78�$6et��Wd�\ˁ*�W�������J��P��*i,��Dt�[NG��"]��x�3+L��(G�OVi��n��\�����3BK�fJZ��%H�h�����&�U����ĸ�l鲄��?梇 �4ǚN7X�q�Ŭ�ǈJ�'��]Ћ��GK!6��08�����`g4���:�Z��/��+^�-��Fi�����*��tH����I��'���ٰ��gr�5.3&����۫�������Kz3�O0���*��������z���������j,)D��oR>Ōo�3�
T>=;=���� �	�{?��vzv<���z���X"���_ƽ�,*��
1��xh�r�J�6�li�`�|�9q�&�1�3x�_d�qWPF�VH?|�q�^T���  