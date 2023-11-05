<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useToast } from "vue-toast-notification";
import axios from "axios";
import emailjs from "emailjs-com";
import VueCookies from "vue-cookies";

const status = ref(false);
const sTime = ref(null);
const eTime = ref(null);
const timer = ref("00:00:00");

const onVacation = ref(false);
const onSickLeave = ref(false);

const route = useRoute();
const id = route.params.id;

let interval;

// Function to get all data
const fetchData = async () => {
  const $toast = useToast();
  try {
    const token = VueCookies.get("token");
    const resp = await axios.get(
      `http://44.207.191.254:4000/api/clocks/${id}`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
    status.value = resp.data.clock.status;
    sTime.value = resp.data.clock.time;
    if (status.value) {
      startTimer(new Date(sTime.value));
    }
  } catch (error) {}
};

// Email has not been set at first
let emailSent = false;

// Function to sent email to alert user that he might of left his timer on
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

// Function to start the time by looking at last time in data
const startTimer = (startTime) => {
  clearInterval(interval);
  interval = setInterval(() => {
    const now = new Date();
    const diff = new Date(now - startTime);
    const hh = String(diff.getUTCHours()).padStart(2, "0");
    const mm = String(diff.getUTCMinutes()).padStart(2, "0");
    const ss = String(diff.getUTCSeconds()).padStart(2, "0");

    // if time has been running for more than 8hours send email to warn user
    const elapsedSeconds = diff / 1000;
    if (elapsedSeconds > 28800 && !emailSent) {
      sendEmail();
      emailSent = true;
    }

    timer.value = `${hh}:${mm}:${ss}`;
  }, 1000);
};

// Function to start the clock
const clock = async () => {
  const $toast = useToast();
  status.value = true;
  sTime.value = new Date().toISOString();
  startTimer(new Date(sTime.value));

  try {
    const token = VueCookies.get("token");
    await axios.post(
      `http://44.207.191.254:4000/api/clocks/${id}?status=true`,
      {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      }
    );
  } catch (error) {
    $toast.error("An error has been encountered!");
    status.value = false;
    clearInterval(interval);
  }
};

// Function to start refrsh clock + Create workingtime
const refresh = async () => {
  const $toast = useToast();
  status.value = false;
  eTime.value = new Date().toISOString();
  clearInterval(interval);
  timer.value = "00:00:00";
  $toast.success("WorkingTime Successfully Created!");
  const token = VueCookies.get("token");
  const clockRequest = axios.post(
    `http://44.207.191.254:4000/api/clocks/${id}?status=false`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );
  const workingTimeRequest = axios.post(
    `http://44.207.191.254:4000/api/workingtimes/${id}?start=${sTime.value}&end=${eTime.value}`,
    {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }
  );

  try {
    await Promise.all([clockRequest, workingTimeRequest]);
  } catch (error) {
    $toast.error("An error has been encountered!");
  }
};

// Retrieve onVacation and onSickLeave values from local storage on page load
onMounted(() => {
  fetchData();

  if (localStorage.getItem("onVacation") === "true") {
    onVacation.value = true;
  }
  if (localStorage.getItem("onSickLeave") === "true") {
    onSickLeave.value = true;
  }
});

// Update local storage when onVacation or onSickLeave values change
const updateLocalStorage = () => {
  localStorage.setItem("onVacation", onVacation.value);
  localStorage.setItem("onSickLeave", onSickLeave.value);
};

// Toggle the value of onVacation and log the updated value
const logVacationStatus = () => {
  onVacation.value = !onVacation.value;
  updateLocalStorage();
};

// Toggle the value of onSickLeave and log the updated value
const logSickLeaveStatus = () => {
  onSickLeave.value = !onSickLeave.value;
  updateLocalStorage();
};
</script>

<template>
  <div>
    <h1
      class="mb-4 text-3xl font-extrabold text-gray-900 dark:text-white md:text-5xl lg:text-6xl"
    >
      <span
        class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400"
        >The Clock</span
      >
    </h1>
    <div class="w-full p-5 bg-white rounded-lg">
      <div class="flex flex-col items-center pb-10">
        <div class="w-full shadow bg-neutral-800 rounded-lg p-6 mb-10">
          <div v-if="onVacation && !onSickLeave">
            <h5 class="text-5xl font-bold text-gray-900 dark:text-white">
              ON VACATION
            </h5>
          </div>
          <div v-if="onSickLeave && !onVacation">
            <h5 class="text-5xl font-bold text-gray-900 dark:text-white">
              ON SICK DAY
            </h5>
          </div>
          <h5
            v-if="!onVacation && !onSickLeave"
            class="text-4xl sm:text-6xl md:text-8xl font-bold text-white"
          >
            {{ timer }}
          </h5>
          <h3
            v-if="onVacation && onSickLeave"
            class="text-4xl font-bold text-gray-900 dark:text-white"
          >
            Choose only one parameter
          </h3>
        </div>

        <div class="flex justify-start">
          <div
            id="app"
            class="w-full shadow bg-neutral-800 rounded-lg p-6 mb-10"
          >
            <div>
              <input
                type="checkbox"
                class="toggle toggle-warning"
                v-model="onVacation"
                @click="logVacationStatus"
              />
              On vacation
            </div>
            <div>
              <input
                type="checkbox"
                class="toggle toggle-info"
                v-model="onSickLeave"
                @click="logSickLeaveStatus"
              />
              On sick leave
            </div>
          </div>
        </div>

        <div v-if="!onVacation && !onSickLeave">
          <div class="flex mt-4 space-x-3 md:mt-6">
            <a
              v-if="status"
              @click="refresh"
              class="scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
              >Stop Shift</a
            >
            <a
              v-else
              @click="clock"
              class="scale-150 inline-flex items-center px-4 py-2 text-sm font-medium text-center text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-700 dark:focus:ring-gray-700"
              >Start Shift</a
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
