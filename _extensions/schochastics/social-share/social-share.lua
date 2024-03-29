local function ensureHtmlDeps()
  quarto.doc.addHtmlDependency({
    name = 'social-share',
    version = '0.1.0',
    stylesheets = {
      'social-share.css',
      '_extensions/quarto-ext/fontawesome/assets/css/all.css'
    }
  })
end

function Meta(m)
  ensureHtmlDeps()
  local share_start = '<div class= "page-columns page-rows-contents page-layout-article"><div class="social-share">'
  local share_end = '</div></div>'
  local share_text = share_start

  local share_url = pandoc.utils.stringify(m.share.permalink)
  if m.share.description~=nil then
    post_title = pandoc.utils.stringify(m.share.description)
  else 
    post_title = pandoc.utils.stringify(m.title)
  end
  if m.share.twitter then
    share_text = share_text .. '<a href="https://twitter.com/share?url='.. share_url .. '&text='.. post_title ..'" target="_blank" class="twitter"><i class="fab fa-twitter fa-fw fa-lg"></i></a>'
  end
  if m.share.linkedin then
    share_text = share_text .. '<a href="https://www.linkedin.com/shareArticle?url='.. share_url ..'&title='.. post_title ..'" target="_blank" class="linkedin"><i class="fa-brands fa-linkedin-in fa-fw fa-lg"></i></a>'
  end
  if m.share.email then
    share_text = share_text .. '  <a href="mailto:?subject='.. post_title ..'&body=Check out this link:'.. share_url ..'" target="_blank" class="email"><i class="fa-solid fa-envelope fa-fw fa-lg"></i></a>'
  end
  if m.share.facebook then
    share_text = share_text .. '<a href="https://www.facebook.com/sharer.php?u='.. share_url ..'" target="_blank" class="facebook"><i class="fab fa-facebook-f fa-fw fa-lg"></i></a>'
  end
  if m.share.reddit then
      share_text = share_text .. '<a href="https://reddit.com/submit?url='.. share_url ..'&title='.. post_title ..'" target="_blank" class="reddit">   <i class="fa-brands fa-reddit-alien fa-fw fa-lg"></i></a>'
  end
  if m.share.stumble then
    share_text = share_text .. '<a href="https://www.stumbleupon.com/submit?url='.. share_url ..'&title='.. post_title ..'" target="_blank" class="stumbleupon"><i class="fa-brands fa-stumbleupon fa-fw fa-lg"></i></a>'
  end
  if m.share.tumblr then
    share_text = share_text .. '<a href="https://www.tumblr.com/share/link?url='.. share_url ..'&name='.. post_title ..'" target="_blank" class="tumblr"><i class="fa-brands fa-tumblr fa-fw fa-lg"></i></a>'
  end
  if m.share.mastodon then
    share_text = share_text .. '<a href="javascript:void(0);" onclick="var mastodon_instance=prompt(\'Mastodon Instance / Server Name?\'); if(typeof mastodon_instance===\'string\' &amp;&amp; mastodon_instance.length){this.href=\'https://\'+mastodon_instance+\'/share?text=' .. post_title..' '.. share_url ..'\'}else{return false;}" target="_blank" class="mastodon"><i class="fa-brands fa-mastodon fa-fw fa-lg"></i></a>'
  end
  share_text = share_text .. share_end
  quarto.doc.includeText("before-body", share_text)
end
