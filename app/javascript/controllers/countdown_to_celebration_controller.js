import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown-to-celebration"
export default class extends Controller {
  static targets = ["countdown"];
  connect() {
    console.log("Connected to countdown_to_celebration controller");
    this.secondsUntilEnd = this.countdownTarget.dataset.secondsUntilEndValue;
    const now = new Date().getTime();
    this.endTime = new Date(now + this.secondsUntilEnd * 1000);
    setInterval(this.countdown.bind(this), 1000);
  }

  countdown() {
    const now = new Date();
    const remainingSeconds = (this.endTime - now) / 1000;
    if(remainingSeconds <= 0) {
      clearInterval(this.coutdown);
      this.countdownTarget.innerHTML = "You are probably a marriage! Congratulations!"
    }

    const secondsPerDay = 3600 * 24;
    const secondsPerHour = 3600 * 1;
    const secondsPerMinute = 60 * 1;

    const days = Math.floor(remainingSeconds / secondsPerDay);
    const hours = Math.floor((remainingSeconds % secondsPerDay) / secondsPerHour);
    const minute = Math.floor((remainingSeconds % secondsPerHour) / secondsPerMinute);
    const seconds = Math.floor(remainingSeconds % secondsPerMinute);

    this.countdownTarget.innerHTML = `Only ${days} days, ${hours} hours, ${minute} minutes and ${seconds} seconds left!`
  }
}
