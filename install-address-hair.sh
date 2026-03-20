#!/bin/bash

# 1. Update Pricing Page Hero & Copy
cat << 'INNEREOF' > src/pages/pricing.astro
---
import Layout from '~/layouts/PageLayout.astro';
import HeroText from '~/components/widgets/HeroText.astro';
import Pricing from '~/components/widgets/Pricing.astro';
import FAQs from '~/components/widgets/FAQs.astro';
import Features3 from '~/components/widgets/Features3.astro';
import { lifetimeDeal } from '~/data/pricingData';

const metadata = { 
  title: 'Pricing | Secure Your Elite Address.Hair URL', 
  description: 'Professional salon vanity URLs with zero monthly fees. Transform your Google Business Profile and Social Bio into a luxury portfolio.' 
};
---
<Layout metadata={metadata}>
  <HeroText 
    tagline="The Professional Standard"
    title="A Stunning Home for Your Artistry. Live in Hours." 
    subtitle="More than just a link—it's your salon's digital flagship. Own a beautiful vanity URL (address.hair/yoursalon) that transforms your social bio and Google 'Website' button into a high-end experience. Present your services in detail, showcase your live Instagram feed automatically, and turn casual scrollers into loyal clients with a professionally managed web presence."
  />

  <Pricing prices={[lifetimeDeal]} />

  <Features3
    title="Elevate Every Touchpoint"
    subtitle="We bridge the gap between your hard work behind the chair and your presence online."
    columns={3}
    items={[
      { 
        title: 'Social Bio Transformation', 
        description: 'Ditch the generic link-in-bio tools. Your Address.Hair URL provides a high-end, branded experience that keeps clients focused on your work, your services, and your booking link.', 
        icon: 'tabler:link' 
      },
      { 
        title: 'Google Business Authority', 
        description: 'The "Website" button on your Google Profile is your most valuable real estate. Replace generic links with a dedicated salon homepage that creates a massive authority signal to local clients.', 
        icon: 'tabler:brand-google' 
      },
      { 
        title: 'Detailed Service Presentation', 
        description: 'Standard apps hide your brilliance. We present your service menu with boutique styling, allowing you to detail your specialty color work, extensions, and styling packages beautifully.', 
        icon: 'tabler:clipboard-list' 
      },
      { 
        title: 'Live Portfolio Sync', 
        description: 'Your best work happens daily. We pull your live Instagram feed directly onto your unique URL, ensuring your website portfolio is always current and vibrant without you lifting a finger.', 
        icon: 'tabler:brand-instagram' 
      },
      { 
        title: 'One-Time License', 
        description: 'No monthly subscriptions or "SaaS Taxes." Pay once and own your professional identity for life. We handle the hosting, security, and updates so you can focus on your clients.', 
        icon: 'tabler:coin' 
      },
      { 
        title: 'White-Glove Delivery', 
        description: 'We are your dedicated digital partners. From setting up your vanity URL to styling your page and syncing your feeds, we handle the technical heavy lifting with same-day delivery.', 
        icon: 'tabler:headset' 
      },
    ]}
  />

  <FAQs
    title="Pricing & Setup Questions"
    items={[
        { 
          title: 'How does the "Same-Day" setup work?', 
          description: 'Once you secure your license, we send a brief form to grab your Instagram handle and service details. If you complete that by 2PM EST, we guarantee your elite digital address will be live before the end of the business day.', 
          icon: 'tabler:bolt' 
        },
        { 
          title: 'Can I use my own .com domain?', 
          description: 'Yes. While the free Address.Hair vanity URL is included, we can fully set up and manage your own custom .com or .salon domain for just $15/year. We handle all the DNS pointing and SSL security for you.', 
          icon: 'tabler:world' 
        },
        { 
          title: 'Is this a monthly subscription?', 
          description: 'No. Address.Hair is a one-time investment. We charge for the setup, boutique design, and permanent hosting. Once your site is live, you never pay us a monthly fee again.', 
          icon: 'tabler:coin' 
        },
        { 
          title: 'What happens if my services change?', 
          description: 'Our support team is here for you. Simply send us your updated menu or brand colors, and we apply the changes as part of your lifetime white-glove support package.', 
          icon: 'tabler:settings' 
        },
    ]}
  />
</Layout>
INNEREOF

# 2. Update Pricing Widget (PayPal Form logic for Guest Checkout + New Tab)
cat << 'INNEREOF' > src/components/widgets/Pricing.astro
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
      <div class="relative overflow-visible flex flex-col rounded-lg border-2 border-primary p-8 text-center shadow-2xl w-full max-w-lg bg-white dark:bg-slate-900">
        
        <div class="absolute -top-4 left-1/2 transform -translate-x-1/2 bg-accent text-white px-4 py-1 rounded-full text-sm font-bold uppercase tracking-widest">
            Lifetime Digital Address
        </div>

        <h3 class="text-2xl font-bold mt-2">{price.title}</h3>
        
        <div class="mt-8 flex-1">
          <div class="flex items-end justify-center">
            <span class="text-5xl font-bold tracking-tight text-primary">${price.price}</span>
            <span class="ml-1 text-xl font-medium text-muted">/ once</span>
          </div>
          <ul role="list" class="mt-8 space-y-4 text-left">
            {price.items.map((item) => (
              <li class="flex items-start">
                <Icon name="tabler:circle-check" class="w-6 h-6 text-green-500 flex-shrink-0" />
                <p class="ml-3 text-base text-muted">{item.description}</p>
              </li>
            ))}
          </ul>
        </div>
        
        <div class="mt-10 p-6 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700">
          <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
            <input type="hidden" name="cmd" value="_xclick" />
            <input type="hidden" name="business" value="ZFG89TK2KESFG" />
            <input type="hidden" name="item_name" value="Address.Hair Professional Vanity URL Setup" />
            <input type="hidden" name="item_number" value="AHURL99" />
            <input type="hidden" name="amount" value="99.00" />
            <input type="hidden" name="currency_code" value="USD" />
            
            <!-- PayPal Guest Checkout Settings -->
            <input type="hidden" name="solution_type" value="Sole">
            <input type="hidden" name="landing_page" value="billing">
            
            <div class="text-left mb-4">
              <label class="block text-sm font-bold mb-2 text-slate-700 dark:text-gray-300">
                1. Choose Your Vanity URL
              </label>
              <div class="relative">
                <input type="hidden" name="on0" value="Vanity URL" />
                <input 
                    type="text" 
                    id="vanity-input" 
                    name="os0" 
                    required 
                    class="w-full px-4 py-3 border-2 border-slate-300 rounded-lg focus:ring-primary focus:border-primary dark:bg-slate-900 dark:border-slate-600 transition-all font-semibold" 
                    placeholder="yoursalon" 
                />
              </div>
              
              <div class="mt-3 p-3 bg-white dark:bg-slate-950 rounded border border-dashed border-primary/50 flex items-center gap-2 overflow-hidden">
                <Icon name="tabler:world" class="w-4 h-4 text-primary animate-pulse" />
                <span class="text-sm font-mono truncate">
                    <span class="text-slate-400">https://</span><span id="vanity-preview" class="text-primary font-bold">yoursalon</span><span class="text-slate-400">.address.hair</span>
                </span>
              </div>
            </div>

            <div class="text-left mb-6">
              <label class="block text-sm font-bold mb-2 text-slate-700 dark:text-gray-300">
                2. Salon Name
              </label>
              <input type="hidden" name="on1" value="Salon Name" />
              <input 
                type="text" 
                name="os1" 
                required 
                class="w-full px-4 py-3 border-2 border-slate-300 rounded-lg dark:bg-slate-900 dark:border-slate-600 transition-all" 
                placeholder="Business Name" 
              />
            </div>

            <button type="submit" class="w-full py-4 px-4 bg-primary hover:bg-blue-700 text-white font-extrabold rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200 text-lg">
              Secure My URL Today
            </button>
            <div class="flex items-center justify-center gap-2 mt-4 text-slate-500">
                <Icon name="tabler:credit-card" class="w-4 h-4" />
                <p class="text-xs font-medium uppercase tracking-tighter">Secure Checkout (Card or PayPal)</p>
            </div>
          </form>
        </div>
      </div>
    ))}
  </div>
</WidgetWrapper>

<script is:inline>
  function initVanityPreview() {
    const input = document.getElementById('vanity-input');
    const preview = document.getElementById('vanity-preview');
    
    if (input && preview) {
      const update = () => {
        let val = input.value.toLowerCase().replace(/[^a-z0-9]/g, '');
        input.value = val;
        preview.textContent = val || 'yoursalon';
      };

      input.addEventListener('input', update);
      update();
    }
  }
  document.addEventListener('astro:page-load', initVanityPreview);
  initVanityPreview();
</script>
INNEREOF

# 3. Execution: Git Push
git add .
git commit -m "UI: Overhauled Pricing copy and updated PayPal form for Guest Checkout in new tab"
git push

echo "----------------------------------------------------"
echo "✅ Pricing Page: Narrative updated for conversion"
echo "✅ PayPal Form: target='_blank' added"
echo "✅ PayPal Form: Billing/Guest landing page forced"
echo "----------------------------------------------------"
