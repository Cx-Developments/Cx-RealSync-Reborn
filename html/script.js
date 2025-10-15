const { createApp } = Vue

createApp({
  // Data properties for the UI state
  data() {
    return {
      isVisible: false,
      overrideStatus: false,
      weatherType: '',
      rainLevel: 0.0,
      windSpeed: 0,
      windDirection: 0
    }
  },
  // Computed properties for dynamic values
  computed: {
    statusText() {
        return this.overrideStatus ? 'Manual Override' : 'Automatic';
    },
    statusColor() {
        return this.overrideStatus ? 'orange' : 'lightgreen';
    }
  },
  // Methods to handle user actions and events
  methods: {
    // Helper function to send data to the Lua script
    post(event, data = {}) {
        fetch(`https://Cx-RealSync-Reborn/${event}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(data)
        });
    },
    setWeather() {
        if (this.weatherType) {
            this.post('setWeather', { weatherType: this.weatherType });
        }
    },
    setRain() {
        if (this.rainLevel !== null && this.rainLevel >= 0.0) {
            this.post('setRain', { rainLevel: this.rainLevel });
        }
    },
    setWind() {
        if (this.windSpeed !== null && this.windDirection !== null) {
            this.post('setWind', { windSpeed: this.windSpeed, windDirection: this.windDirection });
        }
    },
    clearOverride() {
        // We can just trigger the command directly
        this.post('runCommand', { command: 'clearoverride' });
    },
    closeNui() {
        this.isVisible = false;
        this.post('closeNui');
    },
    // Listener for messages from the Lua client script
    handleMessage(event) {
        const item = event.data;
        if (item.type === 'openNui') {
            this.isVisible = true;
            this.overrideStatus = item.status;
        } else if (item.type === 'updateStatus') {
            this.overrideStatus = item.status;
        }
    }
  },
  // Lifecycle hook to add the event listener when the app is ready
  mounted() {
    window.addEventListener('message', this.handleMessage);
  },
  // Lifecycle hook to clean up the listener
  beforeUnmount() {
    window.removeEventListener('message', this.handleMessage);
  }
}).mount('#app')