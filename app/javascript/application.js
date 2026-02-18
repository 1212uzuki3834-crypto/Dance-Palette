// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
document.addEventListener("turbo:load", () => {

  const targets = document.querySelectorAll(".scroll-fade");

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if(entry.isIntersecting){

        const delay = entry.target.dataset.delay || 0;

        setTimeout(() => {
          entry.target.classList.add("active");
        }, delay);

      }
    });
  });

  targets.forEach(target => observer.observe(target));

});

