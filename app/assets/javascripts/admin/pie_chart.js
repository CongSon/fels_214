var pieChart = {
  options: {
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie'
    },
    title: {
      text: I18n.t("mark_statistic")
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
              enabled: true,
              format: '<b>{point.name}</b>: {point.percentage:.1f} %',
          }
      }
    },
    series: []
  },

  initialize: function() {
    $.getJSON('/admin/pie_chart.json', function(data) {
      pieChart.options.series = []
      $.each(data, function(i, json_data) {
        pieChart.options.series.push({
          name: json_data.name,
          colorByPoint: json_data.colorByPoint,
          data: json_data.data
        });
      });
      pieChart.draw_chart();
    });
  },

  draw_chart: function() {
    Highcharts.chart('chart-pie-report', pieChart.options);
  }
};
