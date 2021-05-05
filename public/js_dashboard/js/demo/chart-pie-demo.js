// Set new default font family and font color to mimic Bootstrap's default styling
(Chart.defaults.global.defaultFontFamily = "Nunito"),
  '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = "#858796";

// Pie Chart Example

if (registro_recharges > 0) {
  labels = [
    "Movistar",
    "Digitel",
    "Movilnet",
    "Cantv",
    "Movistar TV",
    "Inter",
    "Simple TV",
  ];
  data = [
    movistar_p,
    digitel_p,
    movilnet_p,
    cantv_p,
    movistar_tv_p,
    inter_p,
    simple_tv_p,
  ];
  backgroundColor = [
    "#019bf2",
    "#5c068c",
    "#f36f09",
    "#020094",
    "#019bf2",
    "#006fba",
    "#1fb2e7",
  ];
  hoverBackgroundColor = [
    "#017ac0",
    "#dc3545",
    "#d16009",
    "#1e1aee",
    "#017ac0",
    "#025b97",
    "#0f8cba",
  ];
  bodyFontColor = "#858796" 
  borderColor = "#dddfeb"
  caretPadding = 10
} else {
  labels = ["Recargas"];
  data = [100];
  backgroundColor = ["#d9dadf"];
  hoverBackgroundColor = ["#bcbcc0"];
  bodyFontColor = "rgb(255,255,255)"
  borderColor = "rgb(255,255,255)"
  caretPadding = 50
}

var ctx = document.getElementById("myPieChart");
myPieChart = new Chart(ctx, {
  type: "doughnut",
  data: {
    labels: labels,
    datasets: [
      {
        data: data,
        backgroundColor: backgroundColor,
        hoverBackgroundColor: hoverBackgroundColor,
        hoverBorderColor: "rgba(234, 236, 244, 1)",
      },
    ],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: bodyFontColor,
      borderColor: borderColor,
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: caretPadding,
    },
    legend: {
      display: false,
    },
    cutoutPercentage: 80,
  },
});
