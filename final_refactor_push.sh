#!/bin/bash

# 1. Update Pricing Widget (UI + Vanity URL Preview Script)
cat << 'INNER' > src/components/widgets/Pricing.astro
---
import { Icon } from 'astro-icon/components';
import Button from '~/components/ui/Button.astro';
import Headline from '~/components/ui/Headline.astro';
import WidgetWrapper from '~/components/ui/WidgetWrapper.astro';
import type { Price } from '~/types';

const { title, subtitle, tagline, prices = [], classes = {}, ...rest } = Astro.props;
---

<WidgetWrapper {...rest} id="pricing" classes={{ container: 'max-w-7xl scroll-mt-16', ...classes.container }} hasBackground>
  <Headline {title} {subtitle} {tagline} classes={{ headline: 'max-w-3xl' }} />
  
  <div class="flex justify-center">
    {prices.map((price) => (
      <div class="relative overflow-visible flex flex-col rounded-lg border-2 border-primary p-8 text-center shadow-lg w-full max-w-lg bg-white dark:bg-slate-900">
        <h3 class="text-2xl font-bold">{price.title}</h3>
        <div class="mt-8 flex-1">
          <div class="flex items-end justify-center">
            <span class="text-5xl font-bold tracking-tight">${price.price}</span>
            <span class="ml-1 text-xl font-medium text-muted">/ lifetime</span>
          </div>
          <ul role="list" class="mt-8 space-y-4 text-left">
            {price.items.map((item) => (
              <li class="flex items-start">
                <Icon name="tabler:circle-check" class="w-6 h-6 text-primary flex-shrink-0" />
                <p class="ml-3 text-base text-muted">{item.description}</p>
              </li>
            ))}
          </ul>
        </div>
        
        <div class="mt-8">
          <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
            <input type="hidden" name="cmd" value="_xclick" />
            <input type="hidden" name="business" value="ZFG89TK2KESFG" />
            <input type="hidden" name="item_name" value="Schedule Hair Professional Vanity URL Setup" />
            <input type="hidden" name="item_number" value="SHURL99" />
            <input type="hidden" name="amount" value="99.00" />
            <input type="hidden" name="currency_code" value="USD" />
            
            <div class="text-left mb-4">
              <label class="block text-sm font-bold mb-1 dark:text-gray-300">Desired Vanity URL</label>
              <input type="hidden" name="on0" value="Vanity URL" />
              <input type="text" id="vanity-input" name="os0" required class="w-full px-4 py-2 border border-gray-300 rounded-lg dark:bg-slate-800" placeholder="yoursalon" />
              <p class="text-xs mt-2 font-mono text-primary font-bold">Preview: <span id="vanity-preview">yoursalon</span>.schedule.hair</p>
            </div>

            <div class="text-left mb-6">
              <label class="block text-sm font-bold mb-1 dark:text-gray-300">Salon Name</label>
              <input type="hidden" name="on1" value="Salon Name" />
              <input type="text" name="os1" required class="w-full px-4 py-2 border border-gray-300 rounded-lg dark:bg-slate-800" placeholder="Salon Business Name" />
            </div>

            <button type="submit" class="w-full py-4 px-4 bg-green-600 hover:bg-green-700 text-white font-bold rounded-lg shadow-md transition duration-200">
              Claim My Vanity URL - $99
            </button>
            <p class="text-xs text-muted mt-3 italic">Secure setup fee. No monthly subscriptions ever.</p>
          </form>
        </div>
      </div>
    ))}
  </div>
</WidgetWrapper>

<script is:inline>
  const input = document.getElementById('vanity-input');
  const preview = document.getElementById('vanity-preview');
  if (input && preview) {
    input.addEventListener('input', (e) => {
      const val = e.target.value.toLowerCase().replace(/[^a-z0-9]/g, '');
      input.value = val;
      preview.textContent = val || 'yoursalon';
    });
  }
</script>
INNER

# 2. Update Home Page (Deep FAQ + Same-Day Setup focus)
cat << 'INNER' > src/pages/index.astro
---
import Layout from '~/layouts/PageLayout.astro';
import Header from '~/components/widgets/Header.astro';
import Hero2 from '~/components/widgets/Hero2.astro';
import Features from '~/components/widgets/Features.astro';
import Steps2 from '~/components/widgets/Steps2.astro';
import Content from '~/components/widgets/Content.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { headerData } from '~/navigation';
import FAQs from '~/components/widgets/FAQs.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { title: 'Schedule.Hair | The Pro Choice for Salon Vanity URLs', description: 'Replace generic links with a beautiful scheduling page on your own professional domain. Instant Google Business Profile integration.' };
---
<Layout metadata={metadata}>
  <Fragment slot="header"><Header {...headerData} isSticky /></Fragment>
  <Hero2
    tagline="Boutique Web Development for Salons"
    title='<span class="text-accent dark:text-white">Your Salon. Your Domain. Your Rules.</span>'
    subtitle="Generic booking links look cheap. We build you a professional vanity booking URL (yoursalon.schedule.hair) that integrates directly with your Google Business 'Schedule' button. Same-day setup, zero tech stress."
    actions={[{ variant: 'primary', text: 'Get Your Booking Link Today', href: '/pricing/' }, { text: 'See How It Works', href: '#howitworks' }]}
    image={{ src: '/images/hero-poster.webp', width: 1024, height: 576 }}
  />
  <Features
    id="features"
    title="Dominate Your Local Market"
    items={[
        { title: 'The "Schedule" Button Pro', description: 'We help you link your vanity URL to the official Google "Schedule" button so clients can book directly from Search.', icon: 'tabler:brand-google' },
        { title: 'Instant Vanity URLs', description: 'Ditch the long, ugly ID strings. Own a link your clients can actually type and remember.', icon: 'tabler:link' },
        { title: 'Boutique Design', description: 'Every app is custom-styled to match your salon’s interior and vibe.', icon: 'tabler:palette' },
        { title: 'Same-Day Delivery', description: 'If you order by 2PM, your vanity URL and booking engine are live before you close for the day.', icon: 'tabler:bolt' },
    ]}
  />
  <div id="howitworks" class="scroll-mt-20">
    <Steps2
      title="Same-Day Professional Setup"
      items={[
        { title: '1. Claim Your URL', description: 'Pick your vanity name and secure the $99 lifetime license.', icon: 'tabler:number-1' },
        { title: '2. We Build the Engine', description: 'Our team builds your mobile-first booking app and styles it to your brand.', icon: 'tabler:number-2' },
        { title: '3. Sync & Book', description: 'We help you drop the link into your Google Profile and Instagram. Start taking appointments instantly.', icon: 'tabler:number-3' },
      ]}
      image={{ src: '/images/testimonial-6.webp', alt: 'Scheduling interface' }}
    />
  </div>
  <Pricing title='One-Time Investment. Forever Access.' prices={[lifetimeDeal]} />
  <FAQs
    title="Deep Dive: How Schedule.Hair Works"
    subtitle="Everything you need to know about upgrading your salon's digital presence."
    items={[
        { title: 'What exactly is a "Vanity URL"?', description: 'Most booking software gives you a messy link like "app.sq.com/u/123-abc". We replace that with a clean, branded address like <strong>velvet.schedule.hair</strong>. It looks professional, builds trust, and is easy for clients to share via text or DM.', icon: 'tabler:link' },
        { title: 'How do you help with Google Business Profiles?', description: 'A Vanity URL is useless if clients can’t find it. We provide a step-by-step "White-Glove" guide to linking your new URL to the blue "Schedule" button on your Google Business listing. This triggers Google’s local SEO signals, helping you rank higher when clients search for stylists in your area.', icon: 'tabler:brand-google' },
        { title: 'Is it really "Same-Day" Setup?', description: 'Yes. We don’t make you wait for weeks. Our team works in real-time. Once you provide your basic info (services and availability), we deploy your app within hours. If you purchase during business hours, you will usually be live before your next client is out of the chair.', icon: 'tabler:bolt' },
        { title: 'Do I need to cancel my existing booking software?', description: 'No! You can use Schedule.Hair as your primary engine, OR as a beautiful "front-door" for your existing system. We act as the high-end presentation layer that makes the booking experience feel like a luxury service before they even arrive.', icon: 'tabler:device-laptop' },
    ]}
  />
</Layout>
INNER

# 3. Update About Page (Focus on Google "Schedule" Button + Professionalism)
cat << 'INNER' > src/pages/about.astro
---
import Hero2 from '~/components/widgets/Hero2.astro';
import Content from '~/components/widgets/Content.astro';
import Layout from '~/layouts/PageLayout.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import { lifetimeDeal } from '~/data/pricingData';
const metadata = { title: 'Our Mission | Schedule.Hair', description: 'Why your salon deserves a professional vanity URL and a high-end booking experience.' };
---
<Layout metadata={metadata}>
  <Hero2
    tagline="The Professional Standard"
    title='More Than Just a <span class="text-accent">Schedule Button</span>'
    subtitle="When a client sees your salon on Google, that blue 'Schedule' button is their first point of contact. We make sure that click leads to a premium branded experience, not a generic spreadsheet."
    actions={[{ variant: 'primary', text: 'Secure My URL', href: '/pricing/' }]}
  />
  
  <Content
    isReversed
    items={[
        { title: 'Custom Vanity Branding', description: 'No generic logos. Your booking page is 100% focused on YOUR salon artistry.', icon: 'tabler:check' },
        { title: 'Mobile-First Speed', description: 'Load times are 3x faster than traditional booking platforms, preventing client drop-off.', icon: 'tabler:device-mobile' },
        { title: 'Google SEO Signal', description: 'Custom URLs indexed by Google help your shop climb the local rankings faster.', icon: 'tabler:rocket' },
        { title: 'Zero Distractions', description: 'We don’t show other salons or "recommended" stylists nearby. We keep the client focused on you.', icon: 'tabler:eye-off' },
        { title: 'Trust & Credibility', description: 'A custom schedule.hair domain signals that you are an established, elite professional.', icon: 'tabler:shield-check' },
    ]}
  >
    <Fragment slot="content">
      <h3 class="text-3xl font-bold mb-4">Professionalism: Stand Out in a Sea of Generic Apps</h3>
      <p class="text-lg text-muted">In the modern beauty industry, your digital handshake is your URL. We provide the polish your brand deserves.</p>
    </Fragment>
    <Fragment slot="image">
       <img src="/images/testimonial-4.webp" alt="Elite salon styling" class="rounded-lg shadow-xl w-full" />
    </Fragment>
  </Content>

  <Pricing title="Ready to Own Your Professional Identity?" prices={[lifetimeDeal]} />
</Layout>
INNER

# 4. Update Pricing Page (Concept Restore + Full Sections)
cat << 'INNER' > src/pages/pricing.astro
---
import Layout from '~/layouts/PageLayout.astro';
import HeroText from '~/components/widgets/HeroText.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import FAQs from '~/components/widgets/FAQs.astro';
import Features3 from '~/components/widgets/Features3.astro';
import { lifetimeDeal } from '~/data/pricingData';
import Hero from '~/components/widgets/Hero.astro';

const metadata = { title: 'Pricing - Schedule.Hair | Save $600/year', description: 'Professional salon booking URLs with zero monthly fees. One-time setup, lifetime hosting.' };
---
<Layout metadata={metadata}>
  <HeroText 
    tagline="Invest Once. Own It Forever."
    title="Stop Paying the 'SaaS Tax'." 
    subtitle="Most booking systems charge $50–$150 every single month. At Schedule.Hair, you pay a flat $99 one-time fee for your vanity URL and boutique booking engine. That is $600+ back in your pocket every year."
  />

  <Pricing prices={[lifetimeDeal]} />

  <Features3
    title="Everything Included in Your $99 License"
    columns={3}
    items={[
      { title: 'Vanity URL Setup', description: 'Your own branded address (yoursalon.schedule.hair) for life.', icon: 'tabler:link' },
      { title: 'GBP Sync Help', description: 'White-glove support to link your URL to Google Business Profile.', icon: 'tabler:brand-google' },
      { title: 'Boutique Design', description: 'Custom brand colors and logo integration for a luxury feel.', icon: 'tabler:palette' },
      { title: 'Mobile Optimization', description: 'Ultra-fast loading for clients booking on iPhone or Android.', icon: 'tabler:device-mobile' },
      { title: 'Unlimited Services', description: 'List everything from quick trims to full balayage packages.', icon: 'tabler:infinity' },
      { title: 'Lifetime Updates', description: 'All future software improvements included at no extra cost.', icon: 'tabler:refresh' },
    ]}
  />

  <FAQs
    title="Pricing Questions"
    items={[
        { title: 'Are there really no monthly fees?', description: 'None. We charge for our expertise in setup and professional hosting. Once it is live, you never pay us another dime.', icon: 'tabler:coin' },
        { title: 'What happens if I change my salon name?', description: 'No problem. We can update your vanity URL for a small maintenance fee, or you can keep your original for life.', icon: 'tabler:settings' },
    ]}
  />
</Layout>
INNER

# 5. Commit and Push
git add .
git commit -m "Final UI polish: Vanity URL preview, deep FAQ, GBP focus, and Pricing page restore"
git push

echo "ALL UPDATES COMPLETE: Vanity URL preview and concept overhaul pushed to Github."
