{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">我的账户</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    {if $config['enable_kill']=="true"}
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">我的帐号</div>
                                            <div class="account-flex">
                                                <span>注销账号</span>
                                                <a class="btn btn-flat" href="kill">
                                                    <span class="icon">not_interested</span>&nbsp;
                                                </a>
                                            </div>
                                        </div>
                                    {/if}
                                    <dl class="dl-horizontal">
                                        <dt>用户名</dt>
                                        <dd>{$user->user_name}</dd>
                                        <dt>邮箱</dt>
                                        <dd>{$user->email}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6">
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-doubleinner">
                                    <p class="card-heading">最近五分钟使用IP</p>
                                    <p>请确认都为自己的IP，如有异常请及时修改连接密码。</p>
                                </div>
                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        <table class="table table-fixed">
                                            <tr>

                                                <th>IP</th>
                                                <th>归属地</th>
                                            </tr>
                                            {foreach $userip as $single=>$location}
                                                <tr>

                                                    <td>{$single}</td>
                                                    <td>{$location}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6">
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-doubleinner">
                                    <p class="card-heading">最近十次登录IP</p>
                                    <p>请确认都为自己的IP，如有异常请及时修改密码。</p>
                                </div>
                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        <table class="table table-fixed">
                                            <tr>

                                                <th>IP</th>
                                                <th>归属地</th>
                                            </tr>
                                            {foreach $userloginip as $single=>$location}
                                                <tr>

                                                    <td>{$single}</td>
                                                    <td>{$location}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-doubleinner">
                                    <p class="card-heading">返利记录</p>
                                </div>

                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        {$paybacks->render()}
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>###</th>
                                                <th>返利用户</th>
                                                <th>返利金额</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            {foreach $paybacks as $payback}
                                                <tr>
                                                    <td><b>{$payback->id}</b></td>
                                                    {if $payback->user()!=null}
                                                        <td>{$payback->user()->user_name}
                                                        </td>
                                                    {else}
                                                        <td>已注销
                                                        </td>
                                                    {/if}
                                                    </td>
                                                    <td>{$payback->ref_get} 元</td>
                                                </tr>
                                            {/foreach}
                                            </tbody>
                                        </table>
                                        {$paybacks->render()}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</main>


{include file='user/footer.tpl'}
{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">流量记录</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="ui-card-wrap">
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner margin-bottom-no">
                                    <p class="card-heading">注意!</p>
                                    <p>部分节点不支持流量记录.</p>
                                    <p>此处只展示最近 72 小时的记录，粒度为分钟。</p>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <div id="log_chart" style="height: 300px; width: 100%;"></div>

                                    <script src="/assets/js/canvasjs.min.js"></script>

                                    <script type="text/javascript">
                                        window.onload = function () {
                                            var log_chart = new CanvasJS.Chart("log_chart",
                                                    {
                                                        zoomEnabled: true,
                                                        title: {
                                                            text: "您的最近72小时流量消耗",
                                                            fontSize: 20

                                                        },
                                                        animationEnabled: true,
                                                        axisX: {
                                                            title: "时间",
                                                            labelFontSize: 14,
                                                            titleFontSize: 18
                                                        },
                                                        axisY: {
                                                            title: "流量/KB",
                                                            lineThickness: 2,
                                                            labelFontSize: 14,
                                                            titleFontSize: 18
                                                        },

                                                        data: [
                                                            {
                                                                type: "scatter",
                                                                {literal}
                                                                toolTipContent: "<span style='\"'color: {color};'\"'><strong>产生时间: </strong></span>{x} <br/><span style='\"'color: {color};'\"'><strong>流量: </strong></span>{y} KB <br/><span style='\"'color: {color};'\"'><strong>产生节点: </strong></span>{jd}",
                                                                {/literal}

                                                                dataPoints: [


                                                                    {$i=0}
                                                                    {foreach $logs as $single_log}
                                                                    {if $i==0}
                                                                    {literal}
                                                                    {
                                                                        {/literal}
                                                                        x: new Date({$single_log->log_time*1000}),
                                                                        y:{$single_log->totalUsedRaw()},
                                                                        jd: "{$single_log->node()->name}"
                                                                        {literal}
                                                                    }
                                                                    {/literal}
                                                                    {$i=1}
                                                                    {else}
                                                                    {literal}
                                                                    , {
                                                                        {/literal}
                                                                        x: new Date({$single_log->log_time*1000}),
                                                                        y:{$single_log->totalUsedRaw()},
                                                                        jd: "{$single_log->node()->name}"
                                                                        {literal}
                                                                    }
                                                                    {/literal}
                                                                    {/if}
                                                                    {/foreach}

                                                                ]
                                                            }

                                                        ]
                                                    });

                                            log_chart.render();
                                        }
                                    </script>

                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</main>


{include file='user/footer.tpl'}
