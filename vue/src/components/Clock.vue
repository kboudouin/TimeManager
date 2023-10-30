<script setup>
import { ref, watch } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
import emailjs from "emailjs-com";

const status = ref(false);
const sTime = ref(null);
const eTime = ref(null);
const timer = ref("00:00:00");


const route = window.location.href;
const id = route.split("/").slice(-1)[0];
let interval;

const fetchData = async () => {
  const $toast = useToast();
  try {
    const resp = await axios.get(`http://44.207.191.254:4000/api/clocks/${id}`);
    status.value = resp.data.clock.status;
    sTime.value = resp.data.clock.time;
    if (status.value) {
      startTimer(new Date(sTime.value));
    }
  } catch (error) {
    $toast.error("An error has been encountered!");
  }
};

let emailSent = false;

const sendEmail = () => {
  const $toast = useToast();

  const serviceID = "service_66ljsq7";
  const templateID = "template_rpkv47p";
  const publicKey = "-wA4cuYHit4lf3cUo";

  const templateParams = {
    to_email: localStorage.getItem("userEmail"),
    to_username: localStorage.getItem("userName"),
    message:
      "You might have forgotten to turn off your timer. If so, please connect to the TimeManager website and end your shift!",
  };

  emailjs.send(serviceID, templateID, templateParams, publicKey).then(
    (response) => {
      $toast.success("Email sent successfully");
      let emailSent = false;
    },
    (err) => {
      console.log(err);
      $toast.error("Failed to send email");
    }
  );
};

const startTimer = (startTime) => {
  clearInterval(interval);
  interval = setInterval(() => {
    const now = new Date();
    const diff = new Date(now - startTime);
    const hh = String(diff.getUTCHours()).padStart(2, "0");
    const mm = String(diff.getUTCMinutes()).padStart(2, "0");
    const ss = String(diff.getUTCSeconds()).padStart(2, "0");

    const elapsedSeconds = diff / 1000;
    if (elapsedSeconds > 28800 && !emailSent) {
      sendEmail();
      emailSent = true;
    }

    timer.value = `${hh}:${mm}:${ss}`;
  }, 1000);
};

const clock = async () => {
  const $toast = useToast();
  status.value = true;
  sTime.value = new Date().toISOString();
  startTimer(new Date(sTime.value));

  try {
    await axios.post(`http://44.207.191.254:4000/api/clocks/${id}?status=true`);
  } catch (error) {
    $toast.error("An error has been encountered!");
    status.value = false;
    clearInterval(interval);
  }
};

const refresh = async () => {
  const $toast = useToast();
  status.value = false;
  eTime.value = new Date().toISOString();
  clearInterval(interval);
  timer.value = "00:00:00";
  $toast.success("WorkingTime Successfully Created!");

  const clockRequest = axios.post(
    `http://44.207.191.254:4000/api/clocks/${id}?status=false`
  );
  const workingTimeRequest = axios.post(
    `http://44.207.191.254:4000/api/workingtimes/${id}?start=${sTime.value}&end=${eTime.value}`
  );

  try {
    await Promise.all([clockRequest, workingTimeRequest]);
  } catch (error) {
    $toast.error("An error has been encountered!");
  }
};

// first fetch on page relaod
fetchData();
</script>

<template>
  <div class="p-4">
    <h1
      class="font-extrabold text-transparent sm:text-2xl md:text-7xl bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400 m-4"
    >
      The Clock
    </h1>
    <div class="p-4 sm:p-5 bg-white rounded-lg w-full">
      <div class="flex flex-col items-center pb-4 sm:pb-10">
        <div
          class="w-full bg-neutral-800 rounded-lg p-4 sm:p-6 mb-4 sm:mb-10 shadow"
        >
          <h5 class="text-4xl sm:text-6xl md:text-8xl font-bold text-white">
            {{ timer }}
          </h5>
        </div>
        <div class="flex mt-4 space-x-2 sm:space-x-3 md:mt-6">
          <button
            v-if="status"
            @click="refresh"
            class="btn font-extrabold inline-flex items-center px-3 sm:px-4 py-1 sm:py-2 text-sm bg-red-600 text-white rounded-lg hover:bg-red-500 focus:ring-4 focus:outline-none focus:ring-blue-300"
          >
            Stop Shift
          </button>
          <button
            v-else
            @click="clock"
            class="btn inline-flex items-center px-3 sm:px-4 py-1 sm:py-2 text-sm font-extrabold text-white bg-base-500 border border-gray-300 rounded-lg hover:bg-gray-500 focus:ring-4 focus:outline-none focus:ring-gray-200"
          >
            Start Shift
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
