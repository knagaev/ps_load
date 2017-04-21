
##########

def simple_copy(table_name):
  import os, os.path, codecs

  main_path = 'C:/PLR/Patstat/tls'
  processed_path = 'C:/PLR/Patstat/tls/processed/'

  if not os.path.exists(processed_path):
    os.makedirs(processed_path)

  with open(os.path.join(processed_path, table_name + '.txt'), 'w', encoding="utf-8") as dst:
    for fname in (f for f in os.listdir(main_path) if os.path.isfile(os.path.join(main_path, f)) and f.startswith(table_name) and f.endswith('txt')):
      with open(os.path.join(main_path, fname), encoding="utf-8") as src:
        is_first_line = True
        for l in src:
          if is_first_line:
            is_first_line = False
            continue
          dst.write(l)

def convert_from_utf8_to_utf16(table_name):
  import os, os.path, codecs

  main_path = 'C:/PLR/Patstat/tls'
  processed_path = 'C:/PLR/Patstat/tls/processed/'

  if not os.path.exists(processed_path):
    os.makedirs(processed_path)

  with open(os.path.join(processed_path, table_name + '.txt'), 'w', encoding="utf-16") as dst:
    for fname in (f for f in os.listdir(main_path) if os.path.isfile(os.path.join(main_path, f)) and f.startswith(table_name) and f.endswith('txt')):
      with open(os.path.join(main_path, fname), encoding="utf-8") as src:
        is_first_line = True
        for l in src:
          if is_first_line:
            is_first_line = False
            continue
          dst.write(l)


def distrib_by_lng(table_name):
  import os, os.path, codecs

  main_path = 'C:/PLR/Patstat/tls'
  processed_path = 'C:/PLR/Patstat/tls/processed/'

  if not os.path.exists(processed_path):
    os.makedirs(processed_path)

  d = dict()
  dest = dict()

  cntr = 0
  max_cntr = 10000

  for fname in (f for f in os.listdir(main_path) if os.path.isfile(os.path.join(main_path, f)) and f.startswith(table_name) and f.endswith('txt')):
    with open(os.path.join(main_path, fname), encoding="utf-8") as src:
      for l in src:
        st = l.find(',"')
        if st == -1:
          continue
        #out_file_name = os.path.splitext(fname)[0] + '_' + l[st+2: st+4] + '.txt'
        out_file_name = table_name + '_' + l[st+2: st+4] + '.txt'
        if not out_file_name in d:
          d[out_file_name] = list()
          dest[out_file_name] = open(os.path.join(processed_path, out_file_name), 'w', encoding="utf-16")
          #dest[out_file_name].write(codecs.BOM_UTF16_LE)
        d[out_file_name].append(l)

        cntr = cntr + 1
        if cntr > max_cntr:
          cntr = 0

          for out_file_name in d:
            for l in d[out_file_name]:
              dest[out_file_name].write(l)
            d[out_file_name] = list()
            #w.close()

      for out_file_name in d:
        for l in d[out_file_name]:
          dest[out_file_name].write(l)
        d[out_file_name] = list()

  for out_file_name in dest:
    dest[out_file_name].close()


distrib_by_lng('tls202')
distrib_by_lng('tls203')

simple_copy('tls201')
simple_copy('tls204')
simple_copy('tls205')
simple_copy('tls207')
simple_copy('tls215')
simple_copy('tls216')
simple_copy('tls222')
simple_copy('tls223')
simple_copy('tls224')
simple_copy('tls227')
simple_copy('tls228')

convert_from_utf8_to_utf16('tls206')
convert_from_utf8_to_utf16('tls209')
convert_from_utf8_to_utf16('tls210')
convert_from_utf8_to_utf16('tls211')
convert_from_utf8_to_utf16('tls212')
convert_from_utf8_to_utf16('tls214')
convert_from_utf8_to_utf16('tls226')
