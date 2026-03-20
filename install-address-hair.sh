#!/bin/bash

# 1. Update Pricing Widget with Enhanced Preview UI
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
          <form id="paypal-form" action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
            <input type="hidden" name="cmd" value="_xclick" />
            <input type="hidden" name="business" value="ZFG89TK2KESFG" />
            <input type="hidden" id="paypal-item-name" name="item_name" value="Address.Hair Professional Vanity URL Setup" />
            <input type="hidden" name="item_number" value="AHURL99" />
            <input type="hidden" name="amount" value="99.00" />
            <input type="hidden" name="currency_code" value="USD" />
            <input type="hidden" name="no_shipping" value="1" />
            <input type="hidden" name="no_note" value="1" />
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
              
              <!-- ENHANCED PREVIEW UI: Bolder, High Contrast, Attractive Scheme -->
              <div class="mt-3 p-4 bg-blue-50 dark:bg-primary/10 rounded-lg border-2 border-dashed border-primary/40 flex items-center gap-3 overflow-hidden shadow-sm">
                <div class="bg-primary rounded-full p-1.5 flex-shrink-0">
                  <Icon name="tabler:world" class="w-4 h-4 text-white animate-pulse" />
                </div>
                <span class="text-base font-mono truncate leading-none">
                    <span class="text-slate-500 dark:text-slate-400 font-medium">https://</span><span id="vanity-preview" class="text-primary dark:text-blue-400 font-black text-lg underline decoration-accent/30 decoration-2 underline-offset-4">yoursalon</span><span class="text-slate-500 dark:text-slate-400 font-medium">.address.hair</span>
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
                id="salon-name-input"
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
    const vanityInput = document.getElementById('vanity-input');
    const vanityPreview = document.getElementById('vanity-preview');
    const salonInput = document.getElementById('salon-name-input');
    const paypalItemName = document.getElementById('paypal-item-name');
    
    if (vanityInput && vanityPreview && salonInput && paypalItemName) {
      const update = () => {
        let vVal = vanityInput.value.toLowerCase().replace(/[^a-z0-9]/g, '');
        vanityInput.value = vVal;
        vanityPreview.textContent = vVal || 'yoursalon';

        const salonVal = salonInput.value || 'New Salon';
        const displayVanity = vVal || 'yoursalon';
        
        paypalItemName.value = `Address.Hair: ${displayVanity}.address.hair (${salonVal})`;
      };

      vanityInput.addEventListener('input', update);
      salonInput.addEventListener('input', update);
      update();
    }
  }
  document.addEventListener('astro:page-load', initVanityPreview);
  initVanityPreview();
</script>
INNEREOF

# 2. Execution: Git Push
git add .
git commit -m "UI: Enhanced Vanity URL preview with bolder text and attractive blue scheme"
git push

echo "----------------------------------------------------"
echo "✅ Vanity URL Preview: Font weight set to black"
echo "✅ Vanity URL Preview: High contrast blue scheme added"
echo "✅ Vanity URL Preview: Subtle background glow added"
echo "----------------------------------------------------"
