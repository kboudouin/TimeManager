<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
import VueCookies from "vue-cookies";
import { useRoute } from "vue-router";
import router from "../router";
</script>

<template>
  <h1 class="text-4xl mt-2 font-bold">Welcome back {{ userUsername }} !</h1>
  <br />

  <div class="heromin-h-screen">
    <div class="hero-content flex-col lg:flex-row-reverse">
      <div class="stats stats-vertical bg-base-200 w-full md:w-96 shadow">
        <div class="stat">
          <div class="stat-title mb-4">Username</div>
          <!-- <div class="stat">{{ userUsername }}</div> -->

          <input
            type="text"
            placeholder="New username"
            class="input input-bordered"
            required
            ref="usernameInput"
            v-model="userUsername"
          />
          <button @click="updateusername" class="btn btn-active">
            UPDATE USERNAME
          </button>
        </div>

        <div class="stat">
          <div class="stat-title">Email</div>
          <!-- <div class="stat">{{ EMAIL }}</div> -->
          <br />
          <input
            type="text"
            placeholder="New email"
            class="input input-bordered"
            required
            ref="emailInput"
            v-model="EMAIL"
          />
          <button @click="updatemail" class="btn btn-active">
            UPDATE EMAIL
          </button>
        </div>
        <div class="stat mt-4">
          <form @submit="(event) => event.preventDefault()">
            <h1 class="text-xl">Delete your account ?</h1>
            <div class="form-control">
              <div class="form-control">
                <label class="label">
                  <span class="label-text">Username</span>
                </label>
                <input
                  type=""
                  placeholder="Enter username"
                  class="input input-bordered"
                  required
                />
              </div>
              <label class="label">
                <span class="label-text">Email</span>
              </label>
              <input
                type="email"
                placeholder="Enter email"
                class="input input-bordered"
                required
              />
            </div>
            <div class="form-control mt-6">
              <button @click="Deleteacc" class="btn btn-error">DELETE</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      isUserConnected: !!localStorage.getItem("userId"),
      userUsername: null,
      id: null,
      EMAIL: null,
      newusername: null,
      newmail: null,
      newid: null,
      token: localStorage.getItem("token"),
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
    // Mail+ID+ s (GET)
    API() {
      console.log("list of users in process...");
      const email1 = this.email;
      const username1 = this.username;
      axios
        .get(`https://epitechproject.com/api/users`, {
          params: {
            email: email1,
            username: username1,
          },
          headers: {
            Authorization: `Bearer ${this.token}`,
          },
        })
        .then((response) => {
          console.log("Users found");
          console.log(response.data);
          if (response.data.users) {
            const user = response.data.users[0];

            localStorage.setItem("userEmail", user.email);
            localStorage.setItem("userUsername", user.username);
            localStorage.setItem("userId", user.id);
            this.isUserConnected = true;
          }
        })
        .catch((error) => {
          console.error("API request failed:", error);
        });
    },

    //
    Deleteacc() {
      axios
        .delete(
          `https://epitechproject.com/api/users/` +
            localStorage.getItem("userId"),
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: USER BEEN DELETED");
          console.log(response.data);
          localStorage.removeItem("userEmail");
          localStorage.removeItem("userUsername");
          localStorage.removeItem("userId");
          this.isUserConnected = false;
          console.log("logging out");
          window.location.replace("/");
          // this.$router.replace("/");
        })
        .catch((error) => {
          console.error("API request failed:", error);
          const $toast = useToast();
          $toast.error("An error occured, please try again later");
        });
    },

    updatemail() {
      this.newmail = this.$refs.emailInput.value;
      console.log(
        "UPDATE MAIL FROM " +
          localStorage.getItem("userId") +
          " TO " +
          this.newmail
      );
      const userId = localStorage.getItem("userId");
      axios
        .put(
          "https://epitechproject.com/api/users/" +
            userId +
            "?email=" +
            this.newmail,
          {},
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: MAIL BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + "logout and login to see changes"
          );
        });
    },

    updateusername() {
      this.newusername = this.$refs.usernameInput.value;
      console.log(
        "UPDATE USERNAME FROM " +
          localStorage.getItem("userId") +
          " TO " +
          this.newusername
      );
      const userId = localStorage.getItem("userId");
      axios
        .put(
          "https://epitechproject.com/api/users/" +
            userId +
            "?username=" +
            this.newusername,
          {},
          {
            headers: {
              Authorization: `Bearer ${this.token}`,
            },
          }
        )
        .then((response) => {
          console.log("API response received: USERNAME BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + " logout and login to see changes"
          );
        });
    },
  },
};
</script>

<style scoped></style>
