<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?php
/**
 * DokuWiki Default Template
 *
 * This is the template for editing image meta data.
 * It is displayed in the media popup.
 *
 * You should leave the doctype at the very top - It should
 * always be the very first line of a document.
 *
 * @link   http://wiki.splitbrain.org/wiki:tpl:templates
 * @author Andreas Gohr <andi@splitbrain.org>
 */
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $conf['lang']?>" lang="<?php echo $conf['lang']?>" dir="ltr">
<head>
  <title><?php echo hsc($lang['mediaselect'])?> [<?php echo hsc($conf['title'])?>]</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

  <?php tpl_metaheaders()?>

  <link rel="shortcut icon" href="<?php echo DOKU_BASE?>images/favicon.ico" />
  <link rel="stylesheet" media="screen" type="text/css" href="<?php echo DOKU_TPL?>layout.css" />
  <link rel="stylesheet" media="screen" type="text/css" href="<?php echo DOKU_TPL?>design.css" />
</head>

<body>
<div class="dokuwiki">
  <?php html_msgarea()?>

  <h1><?php echo hsc($lang['metaedit'])?> <code><?php echo hsc(noNS($IMG))?></code></h1>

  <div class="mediaedit">
		<?php/* everything in meta array is tried to save and read */?>

 		<div class="data">
			<form action="<?php echo DOKU_BASE?>lib/exe/media.php" accept-charset="utf-8" method="post">
				<input type="hidden" name="edit" value="<?php echo hsc($IMG)?>" />
				<input type="hidden" name="save" value="1" />

				<label for="title"><?php echo $lang['img_title']?></label>
				<input type="text" name="meta[Iptc.Headline]" id="title" class="edit"
         value="<?php echo hsc(tpl_img_getTag('IPTC.Headline'))?>" /><br />

				<label for="caption"><?php echo $lang['img_caption']?></label>
				<textarea name="meta[Iptc.Caption]" id="caption" class="edit" rows="5"><?php
          echo hsc(tpl_img_getTag(array('IPTC.Caption',
                                        'EXIF.UserComment',
                                        'EXIF.TIFFImageDescription',
                                        'EXIF.TIFFUserComment')));
        ?></textarea><br />

				<label for="artist"><?php echo $lang['img_artist']?></label>
				<input type="text" name="meta[Iptc.Byline]" id="artist" class="edit"
         value="<?php echo hsc(tpl_img_getTag(array('Iptc.Byline',
                                                    'Exif.TIFFArtist',
                                                    'Exif.Artist',
                                                    'Iptc.Credit')))?>" /><br />

				<label for="copy"><?php echo $lang['img_copyr']?></label>
				<input type="text" name="meta[Iptc.CopyrightNotice]" id="copy" class="edit"
         value="<?php echo hsc(tpl_img_getTag(array('Iptc.CopyrightNotice','Exif.TIFFCopyright','Exif.Copyright')))?>" /><br />


				<label for="keywords"><?php echo $lang['img_keywords']?></label>
        <textarea name="meta[Iptc.Keywords]" id="keywords" class="edit"><?php
          echo hsc(tpl_img_getTag(array('IPTC.Keywords',
                                        'EXIF.Category')));
        ?></textarea><br />


				<input type="submit" value="<?php echo $lang['btn_save']?>" title="ALT+S"
         accesskey="s" class="button" />

			</form>
 		</div>


    <div class="footer">
      <hr>
        <?php tpl_button('backtomedia')?>
    </div>
  </div>

</div>
</body>
</html>

